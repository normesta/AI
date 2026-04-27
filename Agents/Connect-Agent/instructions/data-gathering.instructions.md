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

## Step 4: Synthesize and Deduplicate

Merge data from all three sources. Deduplicate overlapping items. Prioritize the personal notes narrative while using M365 and ADO data as supporting evidence.

Flag any items from M365 or ADO that represent **new impact** not mentioned in the personal notes — these should be included in the final document.
