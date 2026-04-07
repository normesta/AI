param(
    [Parameter(Mandatory = $true)]
    [string]$TargetRepoPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Copy-CheckedFile {
    param(
        [Parameter(Mandatory = $true)] [string]$Source,
        [Parameter(Mandatory = $true)] [string]$Destination
    )

    if (-not (Test-Path -LiteralPath $Source)) {
        throw "Source file not found: $Source"
    }

    $destinationDir = Split-Path -Path $Destination -Parent
    if (-not (Test-Path -LiteralPath $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir -Force | Out-Null
    }

    Copy-Item -LiteralPath $Source -Destination $Destination -Force
    Write-Host "Copied: $Source -> $Destination"
}

$repoRoot = Resolve-Path "."
if (-not (Test-Path -LiteralPath $TargetRepoPath)) {
    New-Item -ItemType Directory -Path $TargetRepoPath -Force | Out-Null
}

$targetRoot = Resolve-Path $TargetRepoPath

# Ensure target .github layout exists.
$dirs = @(
    ".github",
    ".github/prompts",
    ".github/instructions",
    ".github/references",
    ".github/config",
    ".github/work-in-progress/qa-agent-ideas"
)

foreach ($dir in $dirs) {
    $full = Join-Path $targetRoot $dir
    if (-not (Test-Path -LiteralPath $full)) {
        New-Item -ItemType Directory -Path $full -Force | Out-Null
    }
}

# Connect production assets.
Copy-CheckedFile -Source (Join-Path $repoRoot "Connect-Agent/.github/copilot-instructions.md") -Destination (Join-Path $targetRoot ".github/copilot-instructions.md")
Copy-CheckedFile -Source (Join-Path $repoRoot "Connect-Agent/.github/prompts/generate-connect.prompt.md") -Destination (Join-Path $targetRoot ".github/prompts/generate-connect.prompt.md")
Copy-CheckedFile -Source (Join-Path $repoRoot "Connect-Agent/instructions/data-gathering.instructions.md") -Destination (Join-Path $targetRoot ".github/instructions/data-gathering.instructions.md")
Copy-CheckedFile -Source (Join-Path $repoRoot "Connect-Agent/instructions/organization-rules.instructions.md") -Destination (Join-Path $targetRoot ".github/instructions/organization-rules.instructions.md")
Copy-CheckedFile -Source (Join-Path $repoRoot "Connect-Agent/instructions/writing-guidelines.instructions.md") -Destination (Join-Path $targetRoot ".github/instructions/writing-guidelines.instructions.md")
Copy-CheckedFile -Source (Join-Path $repoRoot "Connect-Agent/references/impact-categories.md") -Destination (Join-Path $targetRoot ".github/references/impact-categories.md")
Copy-CheckedFile -Source (Join-Path $repoRoot "Connect-Agent/config/variables.yaml") -Destination (Join-Path $targetRoot ".github/config/variables.yaml")

# Q&A idea agents (WIP/future ideas).
Copy-CheckedFile -Source (Join-Path $repoRoot "Questions-and-answers-agents/Microsoft-Q&A-agent.md") -Destination (Join-Path $targetRoot ".github/work-in-progress/qa-agent-ideas/microsoft-qa.agent.md")
Copy-CheckedFile -Source (Join-Path $repoRoot "Questions-and-answers-agents/Stack-Overflow-agent.md") -Destination (Join-Path $targetRoot ".github/work-in-progress/qa-agent-ideas/stack-overflow.agent.md")
Copy-CheckedFile -Source (Join-Path $repoRoot "Questions-and-answers-agents/Email-user-group-agent.md") -Destination (Join-Path $targetRoot ".github/work-in-progress/qa-agent-ideas/email-user-group.agent.md")

Write-Host ""
Write-Host "Migration export complete."
Write-Host "Next: update provenance in your personal repo README with source repo, date, and baseline SHA."
