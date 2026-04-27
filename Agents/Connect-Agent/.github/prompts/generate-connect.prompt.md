---
mode: "agent"
description: "Generate a Connect (performance review) document summarizing business impact for the period."
inputs:
  - id: "connectPeriodStart"
    description: "Start date of the Connect period (MM-DD-YYYY)."
  - id: "connectPeriodEnd"
    description: "End date of the Connect period (MM-DD-YYYY)."
  - id: "personalNotesPath"
    description: "Path to the file that contains your onal Connect notes."
  - id: "exampleDocumentPath"
    description: "Path to an example Connect document from a previous period."
  - id: "adoUserStoriesQuery"
    description: "ADO query URL for your completed user stories in the Connect period."
  - id: "adoMentionsQuery"
    description: "(Optional) ADO query URL for items that mention you by name. Leave blank if not applicable."
---

# Generate Connect Document

You are writing a **Connect document** — a semi-annual performance review that captures business impact for the period **{{connectPeriodStart}}** through **{{connectPeriodEnd}}**.

## Your Task

Produce a polished document titled **"Connect: Looking Back"** that summarizes the user's business impact during the Connect period. Follow the instructions below carefully.

### 1. Gather Data

Follow the data-gathering process defined in #file:instructions/data-gathering.instructions.md.

Use these sources:
- **Personal notes** at `{{personalNotesPath}}` — this is the primary source. Read all files in this folder and extract every activity, accomplishment, outcome, and impact statement.
- **M365 activity** — use the WorkIQ MCP server to find Teams chats, meeting transcripts, and documents from the period.
- **ADO work items** — use the ADO MCP server to query:
  - User stories: `{{adoUserStoriesQuery}}`
  - Mentions (if provided): `{{adoMentionsQuery}}` — skip this source if the value is blank.

### 2. Organize

Follow the organization rules in #file:instructions/organization-rules.instructions.md.

Use the three impact categories defined in #file:references/impact-categories.md as H2 headings. Assign each impact item to its best-fit category.

Refer to the example document at `{{exampleDocumentPath}}` for style and structure guidance.

### 3. Write

Follow the writing guidelines in #file:instructions/writing-guidelines.instructions.md.

Key principles:
- Focus on **big rocks** — major deliverables and outcomes, not task lists.
- Lead with **impact**, follow with supporting activities.
- Include **measurable outcomes** where available; use qualitative evidence otherwise.
- Show how work **built on others' contributions** and **enabled others' success**.

### 4. Deliver

Output the Connect document as a **Word document** (`.docx`). If direct Word generation is not possible, produce well-formatted Markdown and note that it should be converted.
