# Connect Agent

A GitHub Copilot agent that generates semi-annual performance review ("Connect") documents by gathering impact data from multiple sources and organizing it into a polished narrative.

## Prerequisites

- **GitHub Copilot** subscription (works with VS Code extension or Copilot CLI).
- **Agent mode** enabled in Copilot Chat (VS Code) or available in Copilot CLI.
- **WorkIQ MCP server** configured in your Copilot settings — used to query Microsoft 365 data (Teams chats, meeting transcripts, Word/Excel/PowerPoint documents).
- **ADO MCP server** configured in your Copilot settings — used to query Azure DevOps work items.

> **Note:** The agent will not install MCP servers for you. Both the WorkIQ and ADO MCP servers must already be set up in your environment before running the prompt.

## Setup

1. Clone this repository.
2. Open `config/variables.yaml` and fill in your personalized values (file paths, dates, ADO query URLs).

## Running the Agent

### Option A: Copilot CLI

1. Open a terminal and `cd` into the repository folder.
2. Start a Copilot CLI session.
3. Type:

   ```
   Generate my connect document
   ```

The agent reads `config/variables.yaml`, follows the instructions and references in the repo, gathers data from your personal notes, M365 activity (via WorkIQ), and ADO work items, and produces a Connect document in `output/`.

### Option B: VS Code

1. Open the repository folder in VS Code. The `.github/copilot-instructions.md` file is auto-loaded by Copilot — no manual configuration needed.
2. Open the **Copilot Chat** panel.
3. Type `/` and select **generate-connect** from the prompt list.
4. Fill in the prompted values:

| Variable              | Required | Description                                          |
|-----------------------|----------|------------------------------------------------------|
| `connectPeriodStart`  | Yes      | Start date of the Connect period (MM-DD-YYYY)        |
| `connectPeriodEnd`    | Yes      | End date of the Connect period (MM-DD-YYYY)          |
| `personalNotesPath`   | Yes      | Full path to a document with your own notes about impact and activities. So, you would consolidate into a document anything you can remember (or you have already recorded) about your impact and activities during the last period. Don’t be overly perfectionist. This document just grounds the agent with your recollection of big rock accomplishments.        |
| `exampleDocumentPath` | Yes      |Full path to an example “Looking Back” document from a prior period. All I did here was export my looking back section into a document so that the agent could have an example of how to structure the output. |
| `adoUserStoriesQuery` | Yes      | ADO query URL for your completed user stories. I just created a query that captured all completed user stories assigned to me over the months of this last connect period. Then, just grab the URL of the query. That’s it.        |
| `adoMentionsQuery`    | No       | ADO query URL for items that mention you by name. Here I created a query that shows dependency items where I was a collaborator. In these cases, the items might not be assigned to me, but I had some involvement in their completion. That involvement manifests as comments in the item or files attached or associated with the item.     |

The agent will gather data from all sources and produce a Connect document organized under three impact categories.

> **Tip:** With the CLI approach, variables are read directly from `config/variables.yaml`, so you won't be prompted for them interactively. With VS Code, you can either pre-fill them in the YAML or enter them when prompted.

## Updating for a New Connect Period

Edit `config/variables.yaml` with your new dates, file paths, and ADO query URLs. That's it — the prompt and instructions don't need to change between periods.

## File Structure

```
Connect-Agent/
├── .github/
│   ├── copilot-instructions.md               # Agent identity (auto-loaded by Copilot)
│   └── prompts/
│       └── generate-connect.prompt.md         # Main prompt — run this to generate a Connect doc
├── instructions/
│   ├── data-gathering.instructions.md         # How to collect data from each source
│   ├── writing-guidelines.instructions.md     # Tone, style, and "big rocks" framing
│   └── organization-rules.instructions.md     # Document structure and output format
├── references/
│   └── impact-categories.md                   # The three H2 impact category definitions
├── config/
│   └── variables.yaml                         # Personalized values
└── README.md                                  # This file
```
