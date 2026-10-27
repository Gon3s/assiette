'use strict';

const fs = require('node:fs');
const {execFile} = require('node:child_process');
const {promisify} = require('node:util');

const MAX_VERSION_CODE = 2100000000;
const API = 'https://androidpublisher.googleapis.com';
const PACKAGE = 'com.gones.assiette';

function versionCode(value) {
  if (!/^[1-9]\d*$/.test(String(value)) || !Number.isSafeInteger(Number(value)) ||
      Number(value) > MAX_VERSION_CODE) {
    throw new Error(`Android versionCode must be between 1 and ${MAX_VERSION_CODE}`);
  }
  return Number(value);
}

function releaseVersion(pubspec, requested = '') {
  // Deliberately accept the simple release form used by Flutter in this repo.
  const match = /^version:\s*["']?(\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?)(?:\+([1-9]\d*))?["']?\s*(?:#.*)?$/m.exec(pubspec);
  if (!match) throw new Error('Missing or invalid pubspec version');
  const name = requested.trim() || match[1];
  if (!/^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-[0-9A-Za-z]+(?:[.-][0-9A-Za-z]+)*)?$/.test(name) ||
      name.length > 50) {
    throw new Error('version_name must be a release version, for example 1.2.3 or 1.2.3-beta.1');
  }
  return {name, minimumCode: versionCode(match[2] || 1)};
}

function nextVersionCode({tracks = [], bundles = [], apks = []}, minimum = 1) {
  const codes = [0];
  for (const artifact of [...bundles, ...apks]) codes.push(versionCode(artifact.versionCode));
  for (const track of tracks) {
    for (const release of track.releases || []) {
      for (const code of release.versionCodes || []) codes.push(versionCode(code));
    }
  }
  return versionCode(Math.max(versionCode(minimum), codes.reduce((a, b) => Math.max(a, b)) + 1));
}

async function accessToken(run = promisify(execFile)) {
  // Official Google SDK uses the ADC file created and cleaned by auth@v3.
  // No IAM impersonation or extra Token Creator role is needed for a JSON key.
  const {stdout} = await run('gcloud', ['auth', 'application-default', 'print-access-token',
    '--scopes=https://www.googleapis.com/auth/androidpublisher'], {timeout: 60000, maxBuffer: 65536});
  const token = stdout.trim();
  if (!token) throw new Error('Google did not return an access token');
  return token;
}

function publisher(token, fetcher = fetch) {
  const base = `/androidpublisher/v3/applications/${PACKAGE}/edits`;
  async function request(path, method = 'GET', body, media = false) {
    const headers = {Authorization: `Bearer ${token}`};
    if (body !== undefined) headers['Content-Type'] = media ? 'application/octet-stream' : 'application/json';
    if (media) headers['Content-Length'] = String(body.length);
    let response;
    try {
      response = await fetcher(`${API}${path}`, {
        method, headers, body: media ? body : body === undefined ? undefined : JSON.stringify(body),
        signal: AbortSignal.timeout(media ? 300000 : 60000),
        redirect: 'error',
      });
    } catch {
      throw new Error(`Play API ${method} request failed or timed out; rerun the workflow`);
    }
    if (!response.ok) {
      const detail = await response.json().catch(() => ({}));
      const message = typeof detail?.error?.message === 'string' ?
        detail.error.message.replaceAll(token, '[redacted]').replace(/[\r\n]/g, ' ').slice(0, 1000) : '';
      const error = new Error(`Play API ${method} failed (HTTP ${response.status})${message ? `: ${message}` : ''}`);
      error.status = response.status;
      // No HTTP client dumps: they can include Authorization headers.
      throw error;
    }
    const text = await response.text();
    return text ? JSON.parse(text) : {};
  }
  const editPath = id => `${base}/${encodeURIComponent(id)}`;

  return {
    async prepare(version) {
      const edit = await request(base, 'POST', {});
      if (!edit.id) throw new Error('Play did not return an edit ID');
      try {
        const tracks = await request(`${editPath(edit.id)}/tracks`);
        const bundles = await request(`${editPath(edit.id)}/bundles`);
        const apks = await request(`${editPath(edit.id)}/apks`);
        return {editId: edit.id, name: version.name, code: nextVersionCode({
          tracks: tracks.tracks, bundles: bundles.bundles, apks: apks.apks,
        }, version.minimumCode)};
      } catch (error) {
        await this.cleanup(edit.id).catch(() => {});
        throw error;
      }
    },
    async publish({editId, name, code, bundle}) {
      code = versionCode(code);
      // Also validate values passed between workflow steps before any upload.
      releaseVersion(`version: ${name}+${code}`);
      if (!editId || !Buffer.isBuffer(bundle) || !bundle.length) throw new Error('Missing edit or AAB');
      const path = editPath(editId);
      const uploaded = await request(`/upload${path}/bundles?uploadType=media`, 'POST', bundle, true);
      if (versionCode(uploaded.versionCode) !== code) {
        throw new Error('Uploaded AAB versionCode differs from the prepared version; publication stopped');
      }
      await request(`${path}/tracks/internal`, 'PUT', {
        track: 'internal',
        releases: [{name: `${name} (${code})`, versionCodes: [String(code)], status: 'completed'}],
      });
      await request(`${path}:commit`, 'POST');
    },
    async cleanup(editId) {
      if (!editId) return;
      try {
        await request(editPath(editId), 'DELETE');
      } catch (error) {
        if (error.status !== 404) throw error;
      }
    },
  };
}

async function main(command, env = process.env) {
  const token = await accessToken();
  // Mask tokens before any subsequent operation can fail in GitHub Actions.
  if (env.GITHUB_ACTIONS) console.log(`::add-mask::${token}`);
  const play = publisher(token);
  if (command === 'prepare') {
    const version = releaseVersion(fs.readFileSync('pubspec.yaml', 'utf8'), env.VERSION_NAME);
    const release = await play.prepare(version);
    fs.appendFileSync(env.GITHUB_OUTPUT,
      `edit_id=${release.editId}\nversion_name=${release.name}\nversion_code=${release.code}\n`);
    console.log(`Preparing ${PACKAGE} ${release.name} (${release.code}) for internal testing`);
  } else if (command === 'publish') {
    const release = {editId: env.PLAY_EDIT_ID, name: env.VERSION_NAME,
      code: env.VERSION_CODE, bundle: fs.readFileSync(env.BUNDLE_PATH)};
    await play.publish(release);
    fs.appendFileSync(env.GITHUB_STEP_SUMMARY,
      `## Play Store — internal\n\nPublished **${release.name} (${release.code})** from \`${env.GITHUB_SHA}\`.\n`);
  } else if (command === 'cleanup') {
    await play.cleanup(env.PLAY_EDIT_ID);
  } else {
    throw new Error('Expected prepare, publish or cleanup');
  }
}

if (require.main === module) {
  main(process.argv[2]).catch(error => {
    // Never print credential-parser or authentication-client error objects.
    console.error(error.message.startsWith('Play API') || error.message.startsWith('Android ') ||
      error.message.startsWith('version_name') || error.message.startsWith('Uploaded AAB') ||
      error.message.startsWith('Missing or invalid pubspec') ? error.message :
      'Play workflow failed. Check the service account, release inputs and bundle path.');
    process.exitCode = 1;
  });
}

module.exports = {releaseVersion, nextVersionCode, publisher, accessToken};
