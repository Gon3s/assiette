'use strict';

const {test} = require('node:test');
const assert = require('node:assert/strict');
const {releaseVersion, nextVersionCode, publisher, accessToken} = require('./play-store.cjs');

test('uses pubspec version and its build floor, with optional dispatch override', () => {
  assert.deepEqual(releaseVersion('name: assiette\nversion: 1.0.0+1\n'),
    {name: '1.0.0', minimumCode: 1});
  assert.deepEqual(releaseVersion('version: "1.2.3-beta.1+42" # release\r\n'),
    {name: '1.2.3-beta.1', minimumCode: 42});
  assert.deepEqual(releaseVersion('version: 1.0.0+99', ' 2.3.0 '),
    {name: '2.3.0', minimumCode: 99});
  assert.deepEqual(releaseVersion('version: 1.2.3', ''), {name: '1.2.3', minimumCode: 1});
});

for (const requested of ['1.2', 'v1.2.3', '1.2.3+42', '1.2.3\nother',
  '1.2.3; echo unsafe', '01.2.3', '1.2.3-..', '1.2.3-' + 'a'.repeat(50)]) {
  test(`rejects invalid visible version: ${JSON.stringify(requested)}`, () => {
    assert.throws(() => releaseVersion('version: 1.0.0+1', requested), /version_name/);
  });
}

test('rejects missing pubspec version and an invalid or overflowing build floor', () => {
  for (const manifest of ['name: assiette', 'version: banana', 'version: 1.0.0+0',
    'version: 1.0.0+2100000001']) {
    assert.throws(() => releaseVersion(manifest));
  }
});

const inventory = {
  tracks: [
    {track: 'internal', releases: [{versionCodes: ['21']}]},
    {track: 'production', releases: [{versionCodes: ['40', '41']}]},
    {track: 'beta', releases: [{status: 'draft', versionCodes: ['45']}]},
    {track: 'empty'},
  ],
  bundles: [{versionCode: 50}],
  apks: [{versionCode: 55}],
};

test('increments above all tracks, including drafts, unassigned bundles and APKs', () => {
  assert.equal(nextVersionCode(inventory), 56);
  assert.equal(nextVersionCode({tracks: inventory.tracks}), 46);
  assert.equal(nextVersionCode({bundles: inventory.bundles}), 51);
  assert.equal(nextVersionCode({}, 100), 100);
  assert.equal(nextVersionCode({}), 1);
});

test('a rerun after a successful release uses the next code, independent of run_number', () => {
  const first = nextVersionCode({bundles: [{versionCode: 21}]});
  assert.equal(first, 22);
  assert.equal(nextVersionCode({bundles: [{versionCode: 21}, {versionCode: first}]}), 23);
});

test('accepts the Android limit, and fails closed for overflow or malformed inventory', () => {
  assert.equal(nextVersionCode({bundles: [{versionCode: 2099999999}]}), 2100000000);
  for (const code of [0, -1, 'invalid', '1.5', '1e3', 2100000000, Number.MAX_SAFE_INTEGER]) {
    assert.throws(() => nextVersionCode({bundles: [{versionCode: code}]}), /versionCode/);
  }
});

function fixture({failAt, status = 403, uploadCode = 56} = {}) {
  const calls = [];
  const fetcher = async (url, options) => {
    const path = new URL(url).pathname;
    const resource = path.split('/').at(-1);
    calls.push({url, ...options});
    assert.equal(new URL(url).origin, 'https://androidpublisher.googleapis.com');
    assert.equal(options.headers.Authorization, 'Bearer secret-token');
    assert.equal(options.redirect, 'error');
    assert.ok(options.signal instanceof AbortSignal);
    if (failAt === resource) {
      return new Response(JSON.stringify({error: {message: 'must not leak secret-token'}}), {status});
    }
    let result = {};
    if (resource === 'edits') result = {id: 'edit-1'};
    if (options.method === 'GET') result = {[resource]: inventory[resource]};
    if (resource === 'bundles' && options.method === 'POST') result = {versionCode: uploadCode};
    return options.method === 'DELETE' ? new Response(null, {status: 204}) :
      new Response(JSON.stringify(result), {status: 200});
  };
  return {calls, play: publisher('secret-token', fetcher)};
}

const release = {editId: 'edit-1', name: '1.2.3', code: 56, bundle: Buffer.from('fake-aab')};

test('prepares from the full Play inventory without modifying a track', async () => {
  const {calls, play} = fixture();
  assert.deepEqual(await play.prepare({name: '1.2.3', minimumCode: 1}),
    {editId: 'edit-1', name: '1.2.3', code: 56});
  assert.deepEqual(calls.map(call => call.method), ['POST', 'GET', 'GET', 'GET']);
  assert.deepEqual(calls.slice(1).map(call => new URL(call.url).pathname.split('/').at(-1)),
    ['tracks', 'bundles', 'apks']);
});

test('uploads the AAB then assigns the verified code to internal and commits the same edit', async () => {
  const {calls, play} = fixture();
  await play.publish(release);
  assert.equal(calls.length, 3);
  assert.match(calls[0].url, /\/upload\/androidpublisher\/v3\/applications\/com.gones.assiette\/edits\/edit-1\/bundles\?uploadType=media$/);
  assert.equal(calls[0].headers['Content-Type'], 'application/octet-stream');
  assert.equal(calls[0].headers['Content-Length'], String(release.bundle.length));
  assert.equal(calls[0].body, release.bundle);
  assert.equal(calls[1].method, 'PUT');
  assert.match(calls[1].url, /\/edit-1\/tracks\/internal$/);
  assert.deepEqual(JSON.parse(calls[1].body), {track: 'internal', releases: [
    {name: '1.2.3 (56)', versionCodes: ['56'], status: 'completed'},
  ]});
  assert.match(calls[2].url, /\/edit-1:commit$/);
  assert.equal(calls[2].method, 'POST');
});

test('never updates or commits a track when the AAB has the wrong versionCode', async () => {
  const {calls, play} = fixture({uploadCode: 55});
  await assert.rejects(play.publish(release), /differs/);
  assert.equal(calls.length, 1);
});

for (const status of [400, 401, 403, 409, 500]) {
  test(`stops on upload HTTP ${status}, without leaking HTTP response or retrying a mutation`, async () => {
    const {calls, play} = fixture({failAt: 'bundles', status});
    await assert.rejects(play.publish(release), error => {
      assert.equal(error.status, status);
      assert.doesNotMatch(error.message, /secret-token/);
      return true;
    });
    assert.equal(calls.length, 1);
  });
}

test('abandons the edit when inventory retrieval fails and never guesses a code', async () => {
  const {calls, play} = fixture({failAt: 'tracks'});
  await assert.rejects(play.prepare({name: '1.2.3', minimumCode: 1}), /HTTP 403/);
  assert.deepEqual(calls.map(call => call.method), ['POST', 'GET', 'DELETE']);
});

test('does not commit if assigning the internal release fails', async () => {
  const {calls, play} = fixture({failAt: 'internal'});
  await assert.rejects(play.publish(release), /HTTP 403/);
  assert.equal(calls.length, 2);
});

test('reports a failed commit and does not report publication success', async () => {
  const {calls, play} = fixture({failAt: 'edit-1:commit', status: 409});
  await assert.rejects(play.publish(release), /HTTP 409/);
  assert.equal(calls.length, 3);
});

test('cleanup deletes only the prepared edit, tolerating an already discarded edit', async () => {
  const {calls, play} = fixture();
  await play.cleanup('edit-1');
  assert.equal(calls[0].method, 'DELETE');
  assert.match(calls[0].url, /\/edits\/edit-1$/);
  await fixture({failAt: 'edit-1', status: 404}).play.cleanup('edit-1');
  await assert.rejects(fixture({failAt: 'edit-1'}).play.cleanup('edit-1'), /HTTP 403/);
  await publisher('token', async () => new Response(null, {status: 200})).cleanup('edit-1');
});

test('handles network failure safely, without retrying an uncertain upload', async () => {
  let calls = 0;
  const play = publisher('secret-token', async () => {
    calls++;
    throw new Error('network error with Authorization: secret-token');
  });
  await assert.rejects(play.publish(release), error => {
    assert.match(error.message, /failed or timed out/);
    assert.doesNotMatch(error.message, /secret-token/);
    return true;
  });
  assert.equal(calls, 1);
});

test('uses Google SDK ADC with only the Play scope, without a shell or impersonation', async () => {
  let calls = 0;
  const token = await accessToken(async (command, args, options) => {
    calls++;
    assert.equal(command, 'gcloud');
    assert.deepEqual(args, ['auth', 'application-default', 'print-access-token',
      '--scopes=https://www.googleapis.com/auth/androidpublisher']);
    assert.equal(options.timeout, 60000);
    return {stdout: 'fake-access-token\n'};
  });
  assert.equal(token, 'fake-access-token');
  assert.equal(calls, 1);
  await assert.rejects(accessToken(async () => ({stdout: '\n'})), /access token/);
});
