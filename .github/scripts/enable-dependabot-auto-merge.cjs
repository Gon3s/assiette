'use strict';

const {requiredChecks, evaluateUpdate} = require('./dependency-policy.cjs');

module.exports = async function enable({github, context, core}) {
  const {owner, repo} = context.repo;
  const repository = `${owner}/${repo}`;
  const event = context.payload.workflow_run;
  const skip = reason => core.info(`Manual review: ${reason}`);
  if (event.event !== 'pull_request' || event.conclusion !== 'success' ||
      event.head_repository?.full_name !== repository) {
    return skip('not a successful same-repository PR run');
  }

  const {data: workflow} = await github.rest.actions.getWorkflow({
    owner, repo, workflow_id: event.workflow_id,
  });
  if (workflow.path !== '.github/workflows/pull-request.yml') {
    return skip('unexpected workflow');
  }
  const jobs = await github.paginate(github.rest.actions.listJobsForWorkflowRun, {
    owner, repo, run_id: event.id, filter: 'latest', per_page: 100,
  });
  if (!requiredChecks.every(name => jobs.some(job =>
    job.name === name && job.conclusion === 'success'))) {
    return skip('required jobs did not all succeed');
  }

  const {data: candidates} = await github.rest.pulls.list({
    owner, repo, state: 'open', base: 'main',
    head: `${owner}:${event.head_branch}`, per_page: 100,
  });
  const matching = candidates.filter(pr => pr.head.sha === event.head_sha);
  if (matching.length !== 1) return skip('no unique PR matching the tested commit');
  const {data: pr} = await github.rest.pulls.get({
    owner, repo, pull_number: matching[0].number,
  });
  if (pr.user.login !== 'dependabot[bot]' || pr.draft || pr.state !== 'open' ||
      pr.base.ref !== 'main' || pr.base.repo.full_name !== repository ||
      pr.head.repo?.full_name !== repository ||
      !pr.head.ref.startsWith('dependabot/pub/') || pr.head.sha !== event.head_sha) {
    return skip('PR author, source, state or tested commit is ineligible');
  }

  const {data: branch} = await github.rest.repos.getBranch({owner, repo, branch: 'main'});
  const protectedChecks = branch.protection?.required_status_checks?.checks ?? [];
  if (!branch.protected || !requiredChecks.every(name => protectedChecks.some(check =>
    check.context === name && check.app_id === 15368))) {
    return skip('main must require both checks from GitHub Actions');
  }

  const files = await github.paginate(github.rest.pulls.listFiles, {
    owner, repo, pull_number: pr.number, per_page: 100,
  });
  const read = async (path, ref) => {
    const {data} = await github.rest.repos.getContent({owner, repo, path, ref});
    if (data.type !== 'file' || data.encoding !== 'base64' || !data.content) {
      throw new Error(`Cannot read ${path} at ${ref}`);
    }
    return Buffer.from(data.content, 'base64').toString('utf8');
  };
  const [beforeManifest, afterManifest, beforeLock, afterLock] = await Promise.all([
    read('pubspec.yaml', pr.base.sha), read('pubspec.yaml', pr.head.sha),
    read('pubspec.lock', pr.base.sha), read('pubspec.lock', pr.head.sha),
  ]);
  const result = evaluateUpdate({files, beforeManifest, afterManifest, beforeLock, afterLock});
  if (!result.eligible) return skip(result.reason);

  // GitHub's strict required checks also guard against later changes to main
  // or the PR head. Do not authorize a commit that replaced the tested head.
  const {data: current} = await github.rest.pulls.get({owner, repo, pull_number: pr.number});
  if (current.state !== 'open' || current.draft ||
      current.head.sha !== event.head_sha || current.base.sha !== pr.base.sha) {
    return skip('PR changed while it was being evaluated');
  }
  if (current.auto_merge) return core.info('Auto-merge is already enabled');
  await github.graphql(`mutation($id: ID!) {
    enablePullRequestAutoMerge(input: {pullRequestId: $id, mergeMethod: SQUASH}) {
      pullRequest { number }
    }
  }`, {id: pr.node_id});
  core.info(`Enabled auto-merge for #${pr.number}: ${result.updated.join(', ')}`);
};
