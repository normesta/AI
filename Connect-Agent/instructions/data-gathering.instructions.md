# Data Gathering Instructions

Follow these steps in order to collect impact data for the Connect document. Each step builds on the previous one.

---

## Step 1: Read the Personal Notes (Primary Source)

Read the user's personal Connect notes document located at the path specified by `personalNotesPath`.

This is the **primary source** — its contents anchor the entire narrative. Extract all described activities, accomplishments, outcomes, and impact statements. Carry every item forward into the organization step. Do not discard anything from this file.

## Step 2: Search M365 Activity via WorkIQ

Use the **WorkIQ MCP server** to query Microsoft 365 data during the Connect period (between `connectPeriodStart` and `connectPeriodEnd`):

- **Teams chat messages** where the user was a participant.
- **Meeting transcripts** that mention the user by name.
- **Word documents, Excel workbooks, and PowerPoint presentations** created or modified by the user during the period.

Use this data to corroborate, enrich, or supplement the personal notes. Look for:
- Impact evidence not captured in the personal notes.
- Collaborative contributions visible in chats or meetings.
- Artifacts (documents, decks) that demonstrate delivered work.

## Step 3: Query Azure DevOps Work Items

Use the **ADO MCP server** to query two work item sets:

1. **User stories query** (`adoUserStoriesQuery`): These are the user's own completed work items. They describe delivered work during the Connect period.
2. **Mentions query** (`adoMentionsQuery`): These are items owned by others where the user is mentioned by name. The user may have contributed work, reviews, or expertise toward these items.

For each query, extract titles, descriptions, acceptance criteria, and any comments that show the user's involvement.

## Step 4: Query GitHub Pull Requests

Use the **GitHub MCP server** (`mcp_github_search_pull_requests`) to retrieve merged pull requests authored by or assigned to the user during the Connect period.

Run **two separate queries** to capture all relevant PRs. Scope both to `repo:MicrosoftDocs/azure-docs-pr`. Convert dates to `YYYY-MM-DD` format for GitHub search syntax:

1. **Author query** — PRs created by the user:
   ```
   repo:MicrosoftDocs/azure-docs-pr is:pr is:merged author:{githubUsername} merged:{connectPeriodStart}..{connectPeriodEnd}
   ```
2. **Assignee query** — PRs assigned to the user (may overlap with author query; deduplicate by PR #):
   ```
   repo:MicrosoftDocs/azure-docs-pr is:pr is:merged assignee:{githubUsername} merged:{connectPeriodStart}..{connectPeriodEnd}
   ```

For each unique PR returned, extract the following fields:

| Field | How to derive it |
|---|---|
| **PR Name** | PR title |
| **PR #** | PR number |
| **Summary of Work** | PR body/description (summarize if long) |
| **Number of Articles impacted** | Count of `.md` files in the PR's changed files list |
| **Azure Service** | Derived from the changed file paths (see rules below) |

### Deriving Azure Service from file paths

Inspect the changed file paths for each PR. Apply these rules **in order**:

1. **Sub-service exceptions** — if any changed file path starts with one of the following prefixes, use the named service regardless of the top-level folder:
   - `articles/virtual-network/IP-Services/` → **IP Services**
   - `articles/private-link/network-security-perimeter/` → **Network Security Perimeter**
2. **Default rule** — use the first path segment after `articles/` as the service name:
   - `articles/load-balancer/` → **Load Balancer**
   - `articles/application-gateway/` → **Application Gateway**
   - `articles/virtual-network/` → **Virtual Network** (only if no sub-service exception matched)

If a PR touches files across multiple services, list all applicable services.

## Step 5: Synthesize and Deduplicate

Merge data from all four sources. Deduplicate overlapping items. Prioritize the personal notes narrative while using M365, ADO, and GitHub PR data as supporting evidence.

Flag any items from M365, ADO, or GitHub PRs that represent **new impact** not mentioned in the personal notes — these should be included in the final document.
