---
name: notion-sync
description: Update the Notion US (user story) page after finishing work in this Flutter project (assiette) — set status to Done and record the short commit hash. Use when the user says a US/feature is finished, asks to "update Notion", or after a commit that closes out a tracked US.
---

# Notion US sync

`CLAUDE.md` requires every delivered US to be marked `Done` in Notion with
the short commit hash in the notes, and blockers noted if any. This used to
be a passive text reminder on session stop; use this skill to actually do it
instead of leaving it to the user.

Never fire this automatically on every `Stop` — a Notion page update is
visible to the rest of the team and picking the wrong page is easy to get
wrong silently. Only run it when there's a clear signal the US is actually
done (user says so, or you just committed the last piece of a tracked US).

## Steps

1. **Get the commit hash** for what's being marked done:
   ```bash
   rtk git log -1 --format=%h
   ```

2. **Find the right Notion page.** Use `notion-search` (or `notion-fetch` if
   the user already gave you a page URL/ID) with the feature/US name as the
   query — e.g. the `lib/features/<feature>/` directory name, or whatever
   the user called the US. If more than one page could plausibly match,
   list the candidates and ask the user which one rather than guessing.

3. **Confirm before writing** if there's any ambiguity about which page or
   whether the US is truly complete (e.g. tests still failing, or the user's
   phrasing was ambiguous about scope). Skip the confirmation only when the
   target page and completion status are unambiguous from context.

4. **Update the page** with `notion-update-page`:
   - Set `status` (or the workspace's equivalent property) to `Done`.
   - Append the short commit hash to the page's notes — don't overwrite
     existing notes content, add to it.
   - If the user mentioned any blocker or caveat during the work, note it
     here too (per `CLAUDE.md`: "Noter blocages éventuels").

5. **Report back** which page was updated and with what hash — one line.

## When not to use

- Work in progress, not yet committed — nothing to record yet.
- No Notion page exists for this change (not everything needs a tracked US;
  don't create one speculatively — ask the user first if unsure).
