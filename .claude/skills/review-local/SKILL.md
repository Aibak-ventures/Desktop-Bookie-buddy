---
name: review-local
description: Review current local code changes (or a specific area) using the project's code-reviewer agent, checked against Bookie Buddy's Clean Architecture rules.
---

Review local changes in Bookie Buddy using the `code-reviewer` agent.

## Args

`$ARGUMENTS` — optional path, file, or area to focus the review on (e.g. `lib/features/bookings/`).
May be empty.

## Steps

1. Determine scope:
   - If `$ARGUMENTS` is empty: the review target is the full set of current local changes
     (staged + unstaged, via `git diff HEAD`) across the whole repo.
   - If `$ARGUMENTS` is provided: the review target is that path/area specifically.

2. Invoke the `code-reviewer` agent (Agent tool, subagent_type: code-reviewer) with a
   self-contained prompt that includes:
   - The scope determined in step 1 (exact path if given, or "all local uncommitted changes"
     if not).
   - Instruction: start by running `git diff HEAD` (scoped to the path, if one was given) to see
     what actually changed. Do not stop at the diff alone — read the full surrounding file(s) for
     any changed code where the diff isn't enough to judge correctness (e.g. understanding why a
     change was made, whether it breaks an invariant elsewhere in the file, or whether a layer
     boundary is violated by something outside the diff hunk).
   - Instruction: apply the full review checklist and CLAUDE.md rules as defined in the
     code-reviewer agent, and return findings in the Done well / Can be better / Must change format.
   - If `$ARGUMENTS` was empty and `git diff HEAD` shows no changes, the agent should say so plainly
     instead of inventing findings.

3. Relay the agent's full review back to the user as-is — do not summarize away findings or
   soften the "Must change" section.
