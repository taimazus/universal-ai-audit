[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [switch]$GlobalOnly,
  [switch]$ProjectOnly,
  [switch]$DryRun,
  [switch]$Force,
  [string]$ProjectPath = (Get-Location).ProviderPath,
  [ValidateSet('all','generic','codex','claude','cursor','copilot','gemini','antigravity')]
  [string[]]$Agents = @('all'),
  [ValidateSet('all','none','audit-remediation','security-audit','pr-review','test-gap-analysis','release-readiness','project-docs','audit-fix-loop')]
  [string[]]$Skills = @('all')
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
$SkillNames=@('audit-remediation','security-audit','pr-review','test-gap-analysis','release-readiness','project-docs','audit-fix-loop')
$SelectedSkills=if($Skills -contains 'none'){@()}elseif($Skills -contains 'all'){$SkillNames}else{@($Skills | Select-Object -Unique)}
$SkillContents=@{}
foreach($name in $SelectedSkills){
  $content=Get-Content -Raw -Encoding UTF8 -LiteralPath (Join-Path $Root ".agents/skills/$name/SKILL.md")
  if([string]::IsNullOrWhiteSpace($content)){throw "Empty skill source: $name"}
  $SkillContents[$name]=$content
}
$HomeDir=[Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile)
$BackupRoot=Join-Path $ProjectPath ('.ai-audit-backup-' + [guid]::NewGuid().ToString('N'))
$Selected = if($Agents -contains 'all'){@('generic','codex','claude','cursor','copilot','gemini','antigravity')}else{$Agents}
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
      $rel=($Path -replace '[:\\/]','_')
      New-Item -ItemType Directory -Path $BackupRoot -Force|Out-Null
      Copy-Item -LiteralPath $Path -Destination (Join-Path $BackupRoot ($rel+'-'+[guid]::NewGuid().ToString('N')))
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
  if($Selected -contains 'codex'){Write-Safe (Join-Path $HomeDir '.codex/skills/enterprise-audit/SKILL.md') $AuditSkill}
  if($Selected -contains 'claude'){Write-Safe (Join-Path $HomeDir '.claude/CLAUDE.md') $AgentText -Append}
  if($Selected -contains 'cursor'){Write-Safe (Join-Path $HomeDir '.cursor/rules/enterprise-audit.mdc') ("---`ndescription: Universal enterprise audit`nalwaysApply: false`n---`n`n"+$Core)}
  if($Selected -contains 'copilot'){Write-Safe (Join-Path $HomeDir '.copilot/instructions/enterprise-audit.instructions.md') ("---`napplyTo: '**/*'`n---`n`n"+$Core)}
  if($Selected -contains 'antigravity'){
    foreach($dir in '.antigravity/skills','.gemini/config/skills','.gemini/antigravity-cli/skills'){Write-Safe (Join-Path $HomeDir "$dir/enterprise-audit/SKILL.md") $AuditSkill}
  }
  foreach($name in $SelectedSkills){
    $content=$SkillContents[$name]
    if($Selected -contains 'codex'){Write-Safe (Join-Path $HomeDir ".codex/skills/$name/SKILL.md") $content}
    if($Selected -contains 'claude'){Write-Safe (Join-Path $HomeDir '.claude/CLAUDE.md') ("# Universal Engineering Skill: $name`n`n"+$content) -Append}
    if($Selected -contains 'cursor'){Write-Safe (Join-Path $HomeDir ".cursor/rules/$name.mdc") ("---`ndescription: Use $name for its scoped engineering workflow`nalwaysApply: false`n---`n`n"+$content)}
    if($Selected -contains 'copilot'){Write-Safe (Join-Path $HomeDir ".copilot/instructions/$name.instructions.md") ("---`napplyTo: '**/*'`n---`n`nWhen asked to use $name, follow this workflow; otherwise these instructions do not apply.`n`n"+$content)}
    if($Selected -contains 'antigravity'){foreach($dir in '.antigravity/skills','.gemini/config/skills','.gemini/antigravity-cli/skills'){Write-Safe (Join-Path $HomeDir "$dir/$name/SKILL.md") $content}}
  }
}
Write-Host "Changed=$Changed Skipped=$Skipped Failed=$Failed"
if($Failed -gt 0){exit 1}else{exit 0}
