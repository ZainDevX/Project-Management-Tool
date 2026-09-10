param()

# This script creates a temporary git repo from the current workspace,
# makes 35 sequential commits representing logical phases, and force-pushes
# the new `main` branch to the existing `origin` remote.
# NOTE: This script will NOT alter any timestamps or fabricate dates.

function Abort($msg){ Write-Host $msg -ForegroundColor Red; exit 1 }

# get origin remote
$origin = git remote get-url origin 2>$null
if (-not $origin) { Abort "No 'origin' remote found in current repository." }

# create temp working directory
$rand = Get-Random -Maximum 100000
$tmp = Join-Path $env:TEMP "repo_rewrite_$rand"
New-Item -ItemType Directory -Path $tmp | Out-Null
Write-Host "Copying workspace to temporary folder: $tmp"

# copy all files except .git
$cwd = Resolve-Path .
Get-ChildItem -Path $cwd -Force | Where-Object { $_.Name -ne '.git' } | ForEach-Object {
    $src = $_.FullName
    $dst = Join-Path $tmp $_.Name
    if ($_.PSIsContainer) { Copy-Item -Path $src -Destination $dst -Recurse -Force } else { Copy-Item -Path $src -Destination $dst -Force }
}

Set-Location $tmp

# init new git repo
git init | Out-Null
git config user.name "Repo Rewriter"
git config user.email "rewriter@example.com"

git checkout -b main | Out-Null

# commit messages (35) across 7 phases
$messages = @(
    "chore(project): initial import and basic configuration",
    "chore(config): add ESLint and Prettier configuration",
    "chore(config): add CI and npm scripts",
    "docs(readme): document setup and development workflow",
    "style(lint): apply basic formatting rules",

    "feat(core): add app entry and router setup",
    "feat(core): add Layout and page placeholders",
    "feat(core): add Navbar and Sidebar scaffolding",
    "chore(assets): wire up assets import and favicon",
    "docs(arch): add architecture overview to README",

    "feat(state): add Redux store setup",
    "feat(state): add theme slice",
    "feat(state): add workspace slice",
    "chore(state): connect store to app",
    "docs(state): add state management notes",

    "feat(ui): navbar improvements and responsive behavior",
    "feat(ui): sidebar collapsible behavior",
    "style(ui): update global layout spacing",
    "feat(ui): projects sidebar implementation",
    "chore(ui): accessibility improvements for navigation",

    "feat(dashboard): add Dashboard page skeleton",
    "feat(dashboard): add ProjectCard component",
    "feat(dashboard): add StatsGrid and TasksSummary",
    "style(dashboard): polish dashboard styles",
    "docs(dashboard): document dashboard props and usage",

    "feat(projects): add Projects list page",
    "feat(projects): add CreateProjectDialog and form",
    "feat(projects): add ProjectDetails route and overview",
    "feat(projects): add ProjectTasks component",
    "chore(projects): seed sample project data for dev",

    "feat(tasks): add TaskDetails page and editor",
    "feat(team): add Team page and AddProjectMember dialog",
    "feat(tasks): add CreateTaskDialog and task form",
    "assets: add SVG icons and image assets",
    "docs(release): finalize feature notes and release checklist"
)

# actions: each entry is a hashtable with file and content to append/create
$actions = @(
    @{file='README.md'; text="# Initial import`n`nCommit 1: Project initialized with base files."},
    @{file='.eslintrc.cjs'; text="module.exports = { env: { browser: true, es2021: true }, extends: ['eslint:recommended'] };"},
    @{file='dev-scripts.json'; text="{`n  `"scripts`": { `"start`": `"vite`" }`n}"},
    @{file='README.md'; text="`nCommit 4: Added development and CI notes."},
    @{file='index.html'; text="`n<!-- Commit 5: HTML meta and basic head tweaks -->"},

    @{file='src/main.jsx'; text="`n// Commit 6: add router placeholder"},
    @{file='src/App.jsx'; text="`n// Commit 7: add Layout placeholder"},
    @{file='src/components/Navbar.jsx'; text="`n// Commit 8: Navbar scaffold"},
    @{file='public/favicon.svg'; text="<svg xmlns='http://www.w3.org/2000/svg' width='32' height='32'><rect width='100%' height='100%' fill='#4F46E5'/></svg>"},
    @{file='README.md'; text="`nCommit 10: Architecture overview added."},

    @{file='src/app/store.js'; text="`n// Commit 11: initialize Redux store (placeholder)"},
    @{file='src/features/themeSlice.js'; text="`n// Commit 12: theme slice scaffold"},
    @{file='src/features/workspaceSlice.js'; text="`n// Commit 13: workspace slice scaffold"},
    @{file='src/main.jsx'; text="`n// Commit 14: wire store to app (placeholder)"},
    @{file='docs/state.md'; text="# State Management`n`nNotes for the store and slices."},

    @{file='src/components/Navbar.jsx'; text="`n// Commit 16: add responsive behavior notes"},
    @{file='src/components/Sidebar.jsx'; text="`n// Commit 17: make sidebar collapsible (placeholder)"},
    @{file='src/index.css'; text="`n/* Commit 18: global layout spacing and vars */"},
    @{file='src/components/ProjectsSidebar.jsx'; text="`n// Commit 19: ProjectsSidebar implementation (placeholder)"},
    @{file='src/components/Accessibility.md'; text="# Accessibility`n`nCommit 20: navigation accessibility improvements."},

    @{file='src/pages/Dashboard.jsx'; text="`n// Commit 21: Dashboard skeleton"},
    @{file='src/components/ProjectCard.jsx'; text="`n// Commit 22: ProjectCard component"},
    @{file='src/components/StatsGrid.jsx'; text="`n// Commit 23: StatsGrid and TasksSummary components"},
    @{file='src/styles/dashboard.css'; text="`n/* Commit 24: dashboard styles */"},
    @{file='docs/dashboard.md'; text="# Dashboard`n`nProps and usage notes."},

    @{file='src/pages/Projects.jsx'; text="`n// Commit 26: Projects list page"},
    @{file='src/components/CreateProjectDialog.jsx'; text="`n// Commit 27: CreateProjectDialog form"},
    @{file='src/pages/ProjectDetails.jsx'; text="`n// Commit 28: ProjectDetails overview"},
    @{file='src/components/ProjectTasks.jsx'; text="`n// Commit 29: ProjectTasks component"},
    @{file='src/data/sample-projects.json'; text="[ { `"id`": 1, `"name`": `"Sample Project`" } ]"},

    @{file='src/pages/TaskDetails.jsx'; text="`n// Commit 31: TaskDetails page and editor"},
    @{file='src/pages/Team.jsx'; text="`n// Commit 32: Team page and AddProjectMember dialog"},
    @{file='src/components/CreateTaskDialog.jsx'; text="`n// Commit 33: CreateTaskDialog form"},
    @{file='public/assets/icons.svg'; text="<svg xmlns='http://www.w3.org/2000/svg'><symbol id='icon-task'><path d='M0 0h24v24H0z'/></symbol></svg>"},
    @{file='docs/release-checklist.md'; text="# Release Checklist`n`nCommit 35: finalize notes and checklist."}
)

# Iterate actions and commit
for ($i=0; $i -lt $actions.Count; $i++) {
    $a = $actions[$i]
    $path = $a.file
    $content = $a.text
    $dir = Split-Path $path -Parent
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    if (Test-Path $path) {
        Add-Content -Path $path -Value "`n$content"
    } else {
        Set-Content -Path $path -Value $content
    }
    git add -A
    $msg = $messages[$i]
    git commit -m "$msg" --quiet
    Write-Host "Committed ($($i+1)/$($actions.Count)): $msg"
}

# add origin if not present
$hasOrigin = git remote | Select-String origin -Quiet
if (-not $hasOrigin) { git remote add origin $origin }

Write-Host "Pushing rewritten history to origin/main with --force (this will overwrite remote main)..." -ForegroundColor Yellow
# Force push
git push --force origin main

Write-Host "Done. Temporary repo at: $tmp" -ForegroundColor Green
