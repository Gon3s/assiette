'use strict';

// Keep this list aligned with the dart-patches group in dependabot.yml.
const dartPackages = new Set([
  'archive', 'collection', 'freezed_annotation', 'http', 'intl',
  'json_annotation', 'mocktail', 'path', 'timezone', 'uuid',
]);
const requiredChecks = ['Flutter quality gate', 'Dependency automation policy'];

function isPatch(before, after) {
  const version = /^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)$/;
  const a = version.exec(before);
  const b = version.exec(after);
  return Boolean(a && b && a[1] === b[1] && a[2] === b[2] &&
    Number(b[3]) > Number(a[3]));
}

function manifestChanges(before, after) {
  const a = before.split('\n');
  const b = after.split('\n');
  if (a.length !== b.length) throw new Error('Manifest structure changed');
  let section;
  for (let i = 0; i < a.length; i++) {
    if (/^\S/.test(a[i])) section = a[i];
    if (a[i] === b[i]) continue;
    const pattern = /^  (\w+): (\^?)(\d+\.\d+\.\d+)\r?$/;
    const oldLine = pattern.exec(a[i]);
    const newLine = pattern.exec(b[i]);
    if (!['dependencies:', 'dev_dependencies:'].includes(section?.trim()) ||
        !oldLine || !newLine || oldLine[1] !== newLine[1] ||
        !dartPackages.has(oldLine[1]) || oldLine[2] !== newLine[2] ||
        !isPatch(oldLine[3], newLine[3])) {
      throw new Error('Manifest change requires manual review');
    }
  }
}

function lockPackages(text) {
  // A deliberately narrow reader for pub's generated format. Unknown layouts
  // require manual review instead of guessing at YAML or evaluating PR data.
  const match = /^([\s\S]*?^packages:\r?\n)([\s\S]*?)(^sdks:[\s\S]*)$/m.exec(text);
  if (!match) throw new Error('Unknown lockfile format');
  const blocks = match[2].match(/^  \w+:\r?\n(?:^    .*\r?\n)*/gm);
  if (!blocks || blocks.join('') !== match[2]) {
    throw new Error('Unknown package layout');
  }
  const packages = new Map();
  for (const block of blocks) {
    const name = /^  (\w+):/.exec(block)[1];
    if (packages.has(name)) throw new Error('Duplicate locked package');
    packages.set(name, block);
  }
  return {packages, surrounding: match[1] + match[3]};
}

function evaluateUpdate({files, beforeManifest, afterManifest, beforeLock, afterLock}) {
  try {
    if (!files.length || files.some(file =>
      !['pubspec.yaml', 'pubspec.lock'].includes(file.filename) ||
      file.status !== 'modified')) {
      throw new Error('Files outside the Dart dependency manifests changed');
    }
    manifestChanges(beforeManifest, afterManifest);
    const before = lockPackages(beforeLock);
    const after = lockPackages(afterLock);
    if (before.surrounding !== after.surrounding ||
        before.packages.size !== after.packages.size) {
      throw new Error('SDK constraints or package membership changed');
    }
    const updated = [];
    for (const [name, oldBlock] of before.packages) {
      const newBlock = after.packages.get(name);
      if (!newBlock) throw new Error('Package removed or replaced');
      if (oldBlock === newBlock) continue;
      const oldVersion = /^    version: "([^"]+)"\r?$/m.exec(oldBlock)?.[1];
      const newVersion = /^    version: "([^"]+)"\r?$/m.exec(newBlock)?.[1];
      const normalize = block => block
        .replace(/^    version: "[^"]+"\r?$/m, '')
        .replace(/^      sha256: .*\r?$/m, '');
      if (!dartPackages.has(name) || !isPatch(oldVersion, newVersion) ||
          !/^    source: hosted\r?$/m.test(oldBlock) ||
          !/^      url: "https:\/\/pub.dev"\r?$/m.test(oldBlock) ||
          normalize(oldBlock) !== normalize(newBlock)) {
        throw new Error(`${name} requires manual review`);
      }
      updated.push(name);
    }
    if (!updated.length) throw new Error('No eligible patch update');
    return {eligible: true, updated};
  } catch (error) {
    return {eligible: false, reason: error.message};
  }
}

module.exports = {dartPackages, requiredChecks, evaluateUpdate};
