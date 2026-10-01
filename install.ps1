[CmdletBinding(SupportsShouldProcess=$true)]
param(
  [switch]$GlobalOnly,
  [switch]$ProjectOnly,
  [switch]$DryRun,
  [switch]$Force,
  [string]$ProjectPath = (Get-Location).ProviderPath,
  [ValidateSet('all','generic','codex','claude','cursor','copilot','gemini','antigravity')]
  [string[]]$Agents = @('all')
)
$ErrorActionPreference='Stop'
if($GlobalOnly -and $ProjectOnly){ throw '-GlobalOnly and -ProjectOnly are mutually exclusive.' }
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
$Core = Get-Content -Raw -LiteralPath (Join-Path $Root 'core/enterprise-audit.md') -Encoding UTF8
$AgentText = Get-Content -Raw -LiteralPath (Join-Path $Root 'AGENTS.md') -Encoding UTF8
$HomeDir=[Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile)
$BackupRoot=Join-Path $ProjectPath ('.ai-audit-backup-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
$Selected = if($Agents -contains 'all'){@('generic','codex','claude','cursor','copilot','gemini','antigravity')}else{$Agents}
$Changed=0; $Skipped=0; $Failed=0
function Write-Safe([string]$Path,[string]$Content,[switch]$Append){
  try{
    $parent=Split-Path -Parent $Path; if($parent -and -not(Test-Path -LiteralPath $parent)){ if(-not $DryRun){New-Item -ItemType Directory -Path $parent -Force|Out-Null} }
    if(Test-Path -LiteralPath $Path){
      $old=Get-Content -Raw -LiteralPath $Path -Encoding UTF8
      if($old -eq $Content -or ($Append -and $old.Contains('Universal Enterprise Audit Agent Instructions'))){$script:Skipped++; return}
      if(-not $Force -and -not $Append){ Write-Warning "Exists, preserving: $Path (use -Force to replace)"; $script:Skipped++; return }
      if(-not $DryRun){$rel=($Path -replace '[:\\/]','_'); New-Item -ItemType Directory -Path $BackupRoot -Force|Out-Null; Copy-Item -LiteralPath $Path -Destination (Join-Path $BackupRoot $rel) -Force}
      if($Append){$Content=$old+"`r`n`r`n"+$Content}
    }
    Write-Host (($(if($DryRun){'[DRY]'}else{'[WRITE]'}))+' '+$Path)
    if(-not $DryRun){[IO.File]::WriteAllText($Path,$Content,[Text.UTF8Encoding]::new($false))}
    $script:Changed++
  }catch{ $script:Failed++; Write-Error -ErrorAction Continue "Failed: $Path :: $($_.Exception.Message)" }
}
function ProjectInstall([string]$P){
  if($Selected -contains 'generic' -or $Selected -contains 'codex'){Write-Safe (Join-Path $P 'AGENTS.md') $AgentText -Append}
  if($Selected -contains 'claude'){Write-Safe (Join-Path $P 'CLAUDE.md') $AgentText -Append}
  if($Selected -contains 'gemini'){Write-Safe (Join-Path $P 'GEMINI.md') $AgentText -Append}
  if($Selected -contains 'cursor'){$mdc="---`ndescription: Universal evidence-based enterprise code audit protocol`nalwaysApply: false`n---`n`n$Core"; Write-Safe (Join-Path $P '.cursor/rules/enterprise-audit.mdc') $mdc}
  if($Selected -contains 'copilot'){Write-Safe (Join-Path $P '.github/instructions/enterprise-audit.instructions.md') ("---`napplyTo: '**/*'`n---`n`n"+$Core)}
  if($Selected -contains 'antigravity'){Write-Safe (Join-Path $P '.antigravity/skills/enterprise-audit/SKILL.md') $Core}
  Write-Safe (Join-Path $P '.ai-audit/core/enterprise-audit.md') $Core
}
if(-not $GlobalOnly){ProjectInstall ([IO.Path]::GetFullPath($ProjectPath))}
if(-not $ProjectOnly){
  if($Selected -contains 'codex'){Write-Safe (Join-Path $HomeDir '.codex/skills/enterprise-audit/SKILL.md') $Core}
  if($Selected -contains 'claude'){Write-Safe (Join-Path $HomeDir '.claude/CLAUDE.md') $AgentText -Append}
  if($Selected -contains 'cursor'){Write-Safe (Join-Path $HomeDir '.cursor/rules/enterprise-audit.mdc') ("---`ndescription: Universal enterprise audit`nalwaysApply: false`n---`n`n"+$Core)}
  if($Selected -contains 'copilot'){Write-Safe (Join-Path $HomeDir '.copilot/instructions/enterprise-audit.instructions.md') ("---`napplyTo: '**/*'`n---`n`n"+$Core)}
  if($Selected -contains 'antigravity'){Write-Safe (Join-Path $HomeDir '.antigravity/skills/enterprise-audit/SKILL.md') $Core}
}
Write-Host "Changed=$Changed Skipped=$Skipped Failed=$Failed"
if($Failed -gt 0){exit 1}else{exit 0}
