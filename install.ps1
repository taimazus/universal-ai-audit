[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [switch]$GlobalOnly,
  [switch]$ProjectOnly,
  [switch]$DryRun,
  [switch]$Force,
  [string]$ProjectPath = (Get-Location).ProviderPath,
  [ValidateSet('all','generic','codex','claude','cursor','copilot','gemini','antigravity','opencode','windsurf','cline','roo')]
  [string[]]$Agents = @('all'),
  [ValidateSet('all','none','audit-remediation','security-audit','pr-review','test-gap-analysis','release-readiness','project-docs','audit-fix-loop','task-orchestrator','git-release-sync','project-builder')]
  [string[]]$Skills = @('all'),
  [string]$UserHome = [Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile)
)
$ErrorActionPreference='Stop'
if($GlobalOnly -and $ProjectOnly){ throw '-GlobalOnly and -ProjectOnly are mutually exclusive.' }
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Core = Get-Content -Raw -LiteralPath (Join-Path $Root 'core/enterprise-audit.md') -Encoding UTF8
$AuditSkill="---`nname: enterprise-audit`ndescription: Comprehensive evidence-based repository audit.`n---`n`n$Core"
$AgentText = Get-Content -Raw -LiteralPath (Join-Path $Root 'AGENTS.md') -Encoding UTF8
if ([string]::IsNullOrWhiteSpace($Core) -or [string]::IsNullOrWhiteSpace($AgentText)) { throw 'Audit source files must not be empty.' }
$InstallerCmdlet=$PSCmdlet
if($Skills -contains 'none' -and $Skills.Count -gt 1){throw "'none' cannot be combined with other skills."}
$SkillNames=@('audit-remediation','security-audit','pr-review','test-gap-analysis','release-readiness','project-docs','audit-fix-loop','task-orchestrator','git-release-sync','project-builder')
$SelectedSkills=if($Skills -contains 'none'){@()}elseif($Skills -contains 'all'){$SkillNames}else{@($Skills | Select-Object -Unique)}
$SkillContents=@{}
foreach($name in $SelectedSkills){
  $content=Get-Content -Raw -Encoding UTF8 -LiteralPath (Join-Path $Root ".agents/skills/$name/SKILL.md")
  if([string]::IsNullOrWhiteSpace($content)){throw "Empty skill source: $name"}
  $SkillContents[$name]=$content
}
$HomeDir=if($ProjectOnly){[IO.Path]::GetFullPath($ProjectPath)}else{[IO.Path]::GetFullPath($UserHome)}
if($GlobalOnly){$ProjectPath=$HomeDir}
$BackupRoot=Join-Path $ProjectPath ('.ai-audit-backup-' + [guid]::NewGuid().ToString('N'))
# Leave room for short backup IDs on Windows PowerShell's legacy path APIs.
if($BackupRoot.Length -gt 200){
  $BackupRoot=Join-Path ([IO.Path]::GetTempPath()) ('.ai-audit-backup-' + [guid]::NewGuid().ToString('N'))
}
$Selected = if($Agents -contains 'all'){@('generic','codex','claude','cursor','copilot','gemini','antigravity','opencode','windsurf','cline','roo')}else{$Agents}
$Changed=0; $Skipped=0; $Failed=0
function Write-Safe([string]$Path,[string]$Content,[switch]$Append){
  try{
    $parent=Split-Path -Parent $Path
    $exists=Test-Path -LiteralPath $Path
    if($exists){
      $old=Get-Content -Raw -LiteralPath $Path -Encoding UTF8
      if($old -eq $Content -or ($Append -and $null -ne $old -and $old.Contains($Content.Trim()))){$script:Skipped++; return}
      if(-not $Force -and -not $Append){Write-Warning "Exists, preserving: $Path (use -Force to replace)"; $script:Skipped++; return}
      if($Append){$Content=$old+"`r`n`r`n"+$Content}
    }
    if($DryRun){Write-Host "[DRY] $Path"; $script:Changed++; return}
    if(-not $InstallerCmdlet.ShouldProcess($Path,'Install audit instructions')){$script:Skipped++; return}
    if($parent -and -not(Test-Path -LiteralPath $parent)){New-Item -ItemType Directory -Path $parent -Force|Out-Null}
    if($exists){
      $backupId=[guid]::NewGuid().ToString('N')
      New-Item -ItemType Directory -Path $BackupRoot -Force|Out-Null
      $backupFile=Join-Path $BackupRoot $backupId
      Copy-Item -LiteralPath $Path -Destination $backupFile
      [IO.File]::WriteAllText(($backupFile+'.path'),[IO.Path]::GetFullPath($Path),[Text.UTF8Encoding]::new($false))
      Write-Host "[BACKUP] $backupFile -> $Path"
    }
    Write-Host "[WRITE] $Path"
    [IO.File]::WriteAllText($Path,$Content,[Text.UTF8Encoding]::new($false))
    $script:Changed++
  }catch{$script:Failed++; Write-Error -ErrorAction Continue "Failed: $Path :: $($_.Exception.Message)"}
}
function ProjectInstall([string]$P){
  if($Selected -contains 'generic' -or $Selected -contains 'codex'){Write-Safe (Join-Path $P 'AGENTS.md') $AgentText -Append}
  if($Selected -contains 'claude'){Write-Safe (Join-Path $P 'CLAUDE.md') $AgentText -Append}
  if($Selected -contains 'gemini'){Write-Safe (Join-Path $P 'GEMINI.md') $AgentText -Append}
  if($Selected -contains 'cursor'){$mdc="---`ndescription: Universal evidence-based enterprise code audit protocol`nalwaysApply: false`n---`n`n$Core"; Write-Safe (Join-Path $P '.cursor/rules/enterprise-audit.mdc') $mdc}
  if($Selected -contains 'copilot'){Write-Safe (Join-Path $P '.github/instructions/enterprise-audit.instructions.md') ("---`napplyTo: '**/*'`n---`n`n"+$Core)}
  if($Selected -contains 'antigravity'){Write-Safe (Join-Path $P '.antigravity/skills/enterprise-audit/SKILL.md') $AuditSkill}
  if($Selected -contains 'codex' -or $Selected -contains 'antigravity'){Write-Safe (Join-Path $P '.agents/skills/enterprise-audit/SKILL.md') $AuditSkill}
  Write-Safe (Join-Path $P 'core/enterprise-audit.md') $Core
  $NativeRoots=@{claude='.claude/skills';cursor='.cursor/skills';copilot='.github/skills';gemini='.gemini/skills';opencode='.opencode/skills';windsurf='.windsurf/skills';cline='.cline/skills';roo='.roo/skills'}
  foreach($agent in $Selected){
    if($NativeRoots.ContainsKey($agent)){
      $dir=$NativeRoots[$agent]
      Write-Safe (Join-Path $P "$dir/enterprise-audit/SKILL.md") $AuditSkill
      foreach($name in $SelectedSkills){Write-Safe (Join-Path $P "$dir/$name/SKILL.md") $SkillContents[$name]}
    }
  }
  foreach($name in $SelectedSkills){
    $content=$SkillContents[$name]
    Write-Safe (Join-Path $P "core/skills/$name/SKILL.md") $content
    $route="# Universal Engineering Skill: $name`nWhen asked to use $name, read core/skills/$name/SKILL.md and follow its scoped workflow."
    if($Selected -contains 'generic' -or $Selected -contains 'codex'){Write-Safe (Join-Path $P 'AGENTS.md') $route -Append}
    if($Selected -contains 'claude'){Write-Safe (Join-Path $P 'CLAUDE.md') $route -Append}
    if($Selected -contains 'gemini'){Write-Safe (Join-Path $P 'GEMINI.md') $route -Append}
    if($Selected -contains 'codex' -or $Selected -contains 'antigravity'){Write-Safe (Join-Path $P ".agents/skills/$name/SKILL.md") $content}
    if($Selected -contains 'cursor'){Write-Safe (Join-Path $P ".cursor/rules/$name.mdc") ("---`ndescription: Use $name for its scoped engineering workflow`nalwaysApply: false`n---`n`n"+$content)}
    if($Selected -contains 'copilot'){Write-Safe (Join-Path $P ".github/instructions/$name.instructions.md") ("---`napplyTo: '**/*'`n---`n`nWhen asked to use $name, follow this workflow; otherwise these instructions do not apply.`n`n"+$content)}
    if($Selected -contains 'antigravity'){Write-Safe (Join-Path $P ".antigravity/skills/$name/SKILL.md") $content}
  }
}
if(-not $GlobalOnly){ProjectInstall ([IO.Path]::GetFullPath($ProjectPath))}
if(-not $ProjectOnly){
  $GlobalRoots=@{
    generic=@('.agents/skills'); codex=@('.agents/skills'); claude=@('.claude/skills')
    cursor=@('.cursor/skills'); copilot=@('.copilot/skills'); gemini=@('.gemini/skills')
    antigravity=@('.gemini/config/skills','.gemini/antigravity-cli/skills')
    opencode=@('.config/opencode/skills');windsurf=@('.codeium/windsurf/skills');cline=@('.cline/skills');roo=@('.roo/skills')
  }
  $Destinations=@($Selected | ForEach-Object {$GlobalRoots[$_]} | Select-Object -Unique)
  foreach($dir in $Destinations){
    Write-Safe (Join-Path $HomeDir "$dir/enterprise-audit/SKILL.md") $AuditSkill
    foreach($name in $SelectedSkills){Write-Safe (Join-Path $HomeDir "$dir/$name/SKILL.md") $SkillContents[$name]}
  }
}
Write-Host "Changed=$Changed Skipped=$Skipped Failed=$Failed"
if($Failed -gt 0){exit 1}else{exit 0}
