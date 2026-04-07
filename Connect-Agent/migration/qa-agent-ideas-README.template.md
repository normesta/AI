# Q&A Agent Ideas (Work in Progress)

This folder contains experimental agent ideas not yet promoted to production prompt paths.

## Purpose

- Incubate new agent patterns safely.
- Test interaction design and output quality.
- Keep production prompts stable.

## Current Ideas

- `microsoft-qa.agent.md`
- `stack-overflow.agent.md`
- `email-user-group.agent.md`

## Required Metadata for Each Idea

Add this header near the top of each WIP file:

```yaml
status: experimental
owner: <your-name-or-alias>
source: normesta/AI
baseline_date: YYYY-MM-DD
baseline_commit: <sha>
```

## Promotion Criteria

1. Clear trigger phrase and description.
2. Successful results in at least 3 realistic runs.
3. No hidden tool assumptions.
4. Stable output contract/template.
5. Acceptable token usage for repeated sessions.

## Promotion Process

1. Copy promoted file into `.github/prompts/` (or relevant production path).
2. Rename to stable production name.
3. Remove or archive WIP copy.
4. Update changelog/provenance notes.

## Notes

- WIP files are intentionally excluded from default production workflows.
- Keep experiments short and focused; split large ideas into multiple files.
