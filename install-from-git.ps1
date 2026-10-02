[CmdletBinding()]
param(
  [string]$Ref='main',
  [string]$Repository='https://github.com/taimazus/universal-ai-audit.git',
  [switch]$GlobalOnly,
  [switch]$ProjectOnly,
  [switch]$DryRun,
  [switch]$Force,
  [string]$ProjectPath=(Get-Location).ProviderPath,
  [string[]]$Agents=@('all'),
  [string[]]$Skills=@('all'),
  [string]$UserHome=[Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile)
)
$ErrorActionPreference='Stop'
if($GlobalOnly -and $ProjectOnly){throw 'GlobalOnly and ProjectOnly are mutually exclusive.'}
if([string]::IsNullOrWhiteSpace($Ref) -or $Ref.StartsWith('-')){throw 'Ref must be a branch or tag name.'}
Get-Command git -ErrorAction Stop | Out-Null
$Checkout=Join-Path ([IO.Path]::GetTempPath()) ('universal-ai-audit-'+[guid]::NewGuid().ToString('N'))
Write-Host "[FETCH] $Repository ref=$Ref -> $Checkout"
& git clone --depth 1 --branch $Ref -- $Repository $Checkout
if($LASTEXITCODE -ne 0){throw 'Git clone failed; installation was not started.'}
$Installer=Join-Path $Checkout 'install.ps1'
if(-not(Test-Path -LiteralPath $Installer -PathType Leaf)){throw 'Downloaded repository has no install.ps1.'}
Write-Host "[SOURCE] $Checkout (retained for inspection)"
$Options=@{ProjectPath=[IO.Path]::GetFullPath($ProjectPath);Agents=$Agents;Skills=$Skills;GlobalOnly=$GlobalOnly;ProjectOnly=$ProjectOnly;DryRun=$DryRun;Force=$Force;UserHome=$UserHome}
& $Installer @Options
exit $LASTEXITCODE
