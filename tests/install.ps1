$ErrorActionPreference='Stop'
$Root=Split-Path -Parent $PSScriptRoot
$Installer=Join-Path $Root 'install.ps1'
$Temp=Join-Path ([IO.Path]::GetTempPath()) ('audit-tests-'+[guid]::NewGuid())
New-Item -ItemType Directory -Path $Temp | Out-Null
function Assert($Condition,[string]$Message){if(-not $Condition){throw $Message}}
function Run-Installer([string[]]$Options){
  if($Options -notcontains '-Skills'){$Options+=@('-Skills','none')}
  & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Installer @Options
  Assert ($LASTEXITCODE -eq 0) 'Installer failed.'
}
$Project=Join-Path $Temp 'project with spaces'
Run-Installer @('-ProjectOnly','-ProjectPath',$Project,'-WhatIf')
Assert (-not(Test-Path $Project)) 'WhatIf created a directory.'
Run-Installer @('-ProjectOnly','-ProjectPath',$Project)
$Core=Join-Path $Project 'core/enterprise-audit.md'
Assert ((Get-FileHash $Core).Hash -eq (Get-FileHash (Join-Path $Root 'core/enterprise-audit.md')).Hash) 'Protocol mismatch.'
foreach($name in 'AGENTS','CLAUDE','GEMINI'){
  Assert ((Get-Content -Raw (Join-Path $Project "$name.md")).Contains('core/enterprise-audit.md')) 'Reference mismatch.'
}
[IO.File]::WriteAllText($Core,'original')
$Before=(Get-FileHash $Core).Hash
$Count=@(Get-ChildItem $Project -Recurse -Force).Count
Run-Installer @('-ProjectOnly','-ProjectPath',$Project,'-Force','-WhatIf')
Assert ((Get-FileHash $Core).Hash -eq $Before) 'WhatIf modified a file.'
Assert (@(Get-ChildItem $Project -Recurse -Force).Count -eq $Count) 'WhatIf created backups.'
Run-Installer @('-ProjectOnly','-ProjectPath',$Project,'-Force','-DryRun')
Assert ((Get-FileHash $Core).Hash -eq $Before) 'DryRun modified a file.'
Run-Installer @('-ProjectOnly','-ProjectPath',$Project,'-Force')
Assert (@(Get-ChildItem $Project -Filter '.ai-audit-backup-*').Count -eq 1) 'Backup missing.'
Assert (@(Get-ChildItem $Project -Filter '.ai-audit-backup-*' | Get-ChildItem | Where-Object {(Get-Content -Raw $_.FullName) -eq 'original'}).Count -eq 1) 'Original backup lost.'
Run-Installer @('-ProjectOnly','-ProjectPath',$Project,'-Skills','all')
foreach($name in 'audit-remediation','security-audit','pr-review','test-gap-analysis','release-readiness','project-docs','audit-fix-loop','task-orchestrator','git-release-sync','project-builder'){
  $SourceHash=(Get-FileHash (Join-Path $Root ".agents/skills/$name/SKILL.md")).Hash
  Assert ((Get-FileHash (Join-Path $Project ".agents/skills/$name/SKILL.md")).Hash -eq $SourceHash) 'Native skill mismatch.'
  Assert ((Get-FileHash (Join-Path $Project "core/skills/$name/SKILL.md")).Hash -eq $SourceHash) 'Portable skill mismatch.'
  Assert ((Get-Content -Raw (Join-Path $Project 'AGENTS.md')).Contains("core/skills/$name/SKILL.md")) 'Skill route missing.'
}
$BeforeFiles=@(Get-ChildItem $Project -Recurse -File | ForEach-Object { $_.FullName+':'+(Get-FileHash $_.FullName).Hash }) -join "`n"
Run-Installer @('-ProjectOnly','-ProjectPath',$Project,'-Skills','all')
$AfterFiles=@(Get-ChildItem $Project -Recurse -File | ForEach-Object { $_.FullName+':'+(Get-FileHash $_.FullName).Hash }) -join "`n"
Assert ($BeforeFiles -eq $AfterFiles) 'Repeated install changed files or created backups.'
$Only=Join-Path $Temp 'selected'
Run-Installer @('-ProjectOnly','-ProjectPath',$Only,'-Agents','codex','-Skills','pr-review')
Assert (Test-Path (Join-Path $Only '.agents/skills/pr-review/SKILL.md')) 'Selected skill missing.'
Assert (-not(Test-Path (Join-Path $Only '.agents/skills/security-audit'))) 'Unselected skill installed.'
$Docs=Join-Path $Temp 'docs-only'
Run-Installer @('-ProjectOnly','-ProjectPath',$Docs,'-Agents','antigravity','-Skills','project-docs')
Assert ((Get-FileHash (Join-Path $Docs '.antigravity/skills/project-docs/SKILL.md')).Hash -eq (Get-FileHash (Join-Path $Root '.agents/skills/project-docs/SKILL.md')).Hash) 'Documentation adapter mismatch.'
Assert (-not(Test-Path (Join-Path $Docs 'core/skills/pr-review'))) 'Unselected skill installed in docs-only mode.'
$Loop=Join-Path $Temp 'loop-only'
Run-Installer @('-ProjectOnly','-ProjectPath',$Loop,'-Agents','antigravity','-Skills','audit-fix-loop')
Assert ((Get-FileHash (Join-Path $Loop '.antigravity/skills/audit-fix-loop/SKILL.md')).Hash -eq (Get-FileHash (Join-Path $Root '.agents/skills/audit-fix-loop/SKILL.md')).Hash) 'Loop adapter mismatch.'
Assert (-not(Test-Path (Join-Path $Loop 'core/skills/project-docs'))) 'Unselected documentation skill installed.'
Run-Installer @('-ProjectOnly','-ProjectPath',(Join-Path $Temp 'skill-whatif'),'-Skills','all','-WhatIf')
Assert (-not(Test-Path (Join-Path $Temp 'skill-whatif'))) 'Skill WhatIf wrote files.'
$ErrorActionPreference='Continue'
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File $Installer -ProjectOnly -ProjectPath $Only -Skills invalid 2>&1 | Out-Null
$ErrorActionPreference='Stop'
Assert ($LASTEXITCODE -ne 0) 'Invalid skill accepted.'
$Global=Join-Path $Temp 'global-home'
Run-Installer @('-GlobalOnly','-UserHome',$Global,'-Skills','all','-WhatIf')
Assert (-not(Test-Path $Global)) 'Global WhatIf wrote files.'
Run-Installer @('-GlobalOnly','-UserHome',$Global,'-Skills','all')
foreach($dir in '.agents/skills','.claude/skills','.cursor/skills','.copilot/skills','.gemini/skills','.gemini/config/skills','.gemini/antigravity-cli/skills','.config/opencode/skills','.codeium/windsurf/skills','.cline/skills','.roo/skills'){
  Assert (Test-Path (Join-Path $Global "$dir/enterprise-audit/SKILL.md")) 'Global base skill missing.'
  foreach($name in 'audit-remediation','security-audit','pr-review','test-gap-analysis','release-readiness','project-docs','audit-fix-loop','task-orchestrator','git-release-sync','project-builder'){
    Assert ((Get-FileHash (Join-Path $Global "$dir/$name/SKILL.md")).Hash -eq (Get-FileHash (Join-Path $Root ".agents/skills/$name/SKILL.md")).Hash) 'Global skill mismatch.'
  }
}
Assert (-not(Test-Path (Join-Path $Global '.claude/CLAUDE.md'))) 'Global install created always-loaded instruction text.'
$Count=@(Get-ChildItem $Global -Recurse -Force).Count
Run-Installer @('-GlobalOnly','-UserHome',$Global,'-Skills','all')
Assert (@(Get-ChildItem $Global -Recurse -Force).Count -eq $Count) 'Repeated global install created extra files.'
$GlobalSelected=Join-Path $Temp 'global-selected'
Run-Installer @('-GlobalOnly','-UserHome',$GlobalSelected,'-Agents','claude','-Skills','pr-review')
Assert (Test-Path (Join-Path $GlobalSelected '.claude/skills/pr-review/SKILL.md')) 'Selected global skill missing.'
Assert (-not(Test-Path (Join-Path $GlobalSelected '.cursor'))) 'Unselected global agent installed.'
$LongProject=Join-Path $Temp ('long-'+('x'*120))
$BuilderProject=Join-Path $Temp 'builder-only'
Run-Installer @('-ProjectOnly','-ProjectPath',$BuilderProject,'-Agents','codex','-Skills','project-builder')
Assert ((Get-FileHash (Join-Path $BuilderProject '.agents/skills/project-builder/SKILL.md')).Hash -eq (Get-FileHash (Join-Path $Root '.agents/skills/project-builder/SKILL.md')).Hash) 'Project builder source mismatch.'
Assert ((Get-Content -Raw (Join-Path $BuilderProject 'AGENTS.md')).Contains('core/skills/project-builder/SKILL.md')) 'Project builder route missing.'
Assert (-not(Test-Path (Join-Path $BuilderProject '.agents/skills/security-audit'))) 'Builder-only installed unrelated skill.'
Run-Installer @('-ProjectOnly','-ProjectPath',$LongProject,'-Agents','codex')
$LongCore=Join-Path $LongProject 'core/enterprise-audit.md'
[IO.File]::WriteAllText($LongCore,'long-path-original')
$UpgradeOutput=@(Run-Installer @('-ProjectOnly','-ProjectPath',$LongProject,'-Agents','codex','-Force'))
$BackupMessage=@($UpgradeOutput | Where-Object {"$_" -like '[[]BACKUP[]]*'})
Assert ($BackupMessage.Count -eq 1) 'Long-path backup location was not reported.'
$LongBackup=([string]$BackupMessage[0] -replace '^\[BACKUP\] ','') -split ' -> ',2
Assert ((Get-Content -Raw -LiteralPath $LongBackup[0]) -eq 'long-path-original') 'Long-path original backup lost.'
Assert ((Get-Content -Raw -LiteralPath ($LongBackup[0]+'.path')) -eq $LongCore) 'Backup path mapping missing.'
Assert ((Get-FileHash $LongCore).Hash -eq (Get-FileHash (Join-Path $Root 'core/enterprise-audit.md')).Hash) 'Long-path upgrade failed.'
$BeforeBackupCount=@(Get-ChildItem -LiteralPath (Split-Path $LongBackup[0]) -File).Count
Run-Installer @('-ProjectOnly','-ProjectPath',$LongProject,'-Agents','codex','-Force')
Assert (@(Get-ChildItem -LiteralPath (Split-Path $LongBackup[0]) -File).Count -eq $BeforeBackupCount) 'Repeated forced upgrade created backups.'
Write-Output 'PASS: PowerShell installer regressions'
