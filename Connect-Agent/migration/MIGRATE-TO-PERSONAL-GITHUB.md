# Migrate to Personal .github Repo

This runbook moves the Connect agent and Q&A idea agents from this repo into your personal `.github` repo while preserving provenance.

## Goal

- Make your personal `.github` repo the source of truth.
- Keep this repo as historical reference.
- Place Q&A agents under a dedicated work-in-progress ideas path.

## Baseline Sources (This Repo)

- `Connect-Agent/.github/copilot-instructions.md`
- `Connect-Agent/.github/prompts/generate-connect.prompt.md`
- `Connect-Agent/instructions/data-gathering.instructions.md`
- `Connect-Agent/instructions/organization-rules.instructions.md`
- `Connect-Agent/instructions/writing-guidelines.instructions.md`
- `Connect-Agent/references/impact-categories.md`
- `Connect-Agent/config/variables.yaml`
- `Questions-and-answers-agents/Microsoft-Q&A-agent.md`
- `Questions-and-answers-agents/Stack-Overflow-agent.md`
- `Questions-and-answers-agents/Email-user-group-agent.md`

## Target Structure (Personal Repo)

- `.github/copilot-instructions.md`
- `.github/prompts/`
- `.github/instructions/`
- `.github/references/`
- `.github/config/`
- `.github/work-in-progress/qa-agent-ideas/`

## One-Command Migration

Run this from this repository root:

```powershell
pwsh -File Connect-Agent/migration/export-to-personal-github.ps1 -TargetRepoPath "C:\path\to\your-personal-github-repo"
```

## What the Script Copies

### Connect production assets

- `Connect-Agent/.github/copilot-instructions.md` -> `.github/copilot-instructions.md`
- `Connect-Agent/.github/prompts/generate-connect.prompt.md` -> `.github/prompts/generate-connect.prompt.md`
- `Connect-Agent/instructions/*.instructions.md` -> `.github/instructions/`
- `Connect-Agent/references/impact-categories.md` -> `.github/references/impact-categories.md`
- `Connect-Agent/config/variables.yaml` -> `.github/config/variables.yaml`

### Q&A idea assets (WIP)

- `Questions-and-answers-agents/Microsoft-Q&A-agent.md` -> `.github/work-in-progress/qa-agent-ideas/microsoft-qa.agent.md`
- `Questions-and-answers-agents/Stack-Overflow-agent.md` -> `.github/work-in-progress/qa-agent-ideas/stack-overflow.agent.md`
- `Questions-and-answers-agents/Email-user-group-agent.md` -> `.github/work-in-progress/qa-agent-ideas/email-user-group.agent.md`

## Post-Migration Manual Steps

1. Add provenance in personal repo `README.md`:
   - Source: `normesta/AI`
   - Baseline path: `Connect-Agent/` and `Questions-and-answers-agents/`
   - Baseline date and commit SHA
2. Split monolithic `generate-connect` into phased prompts:
   - `connect-gather.prompt.md`
   - `connect-organize.prompt.md`
   - `connect-write.prompt.md`
   - `connect-refine.prompt.md`
   - `connect-run.prompt.md` (orchestrator)
3. Keep Q&A files in WIP until promotion criteria are met.
4. Add `.github/work-in-progress/qa-agent-ideas/README.md` with status, next experiments, and promotion criteria.
   - Starter template in this repo: `Connect-Agent/migration/qa-agent-ideas-README.template.md`

## Promotion Criteria for Q&A WIP to Production

- Clear user trigger phrase and prompt description.
- Tested interaction flow in at least 3 real runs.
- No hidden assumptions on tools not available in your environment.
- Output schema documented and stable.
- Token footprint acceptable for repeated use.

## Notes

- This migration is intentionally one-way for now (manual upstream sync).
- Do not dual-maintain production logic in both repos.
