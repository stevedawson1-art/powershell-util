[CmdletBinding()]
param(
    [string]$Filter
)

$ErrorActionPreference = 'Stop'

$moduleDirectory = $PSScriptRoot
$moduleManifest = Join-Path $moduleDirectory 'Microsoft.PowerShell.ConsoleGuiTools.psd1'
$moduleBinary = Join-Path $moduleDirectory 'Microsoft.PowerShell.ConsoleGuiTools.dll'

if (-not (Test-Path -LiteralPath $moduleBinary -PathType Leaf)) {
    $moduleDirectory = Join-Path $PSScriptRoot 'module'
    $moduleManifest = Join-Path $moduleDirectory 'Microsoft.PowerShell.ConsoleGuiTools.psd1'
    $moduleBinary = Join-Path $moduleDirectory 'Microsoft.PowerShell.ConsoleGuiTools.dll'
}

if (-not (Test-Path -LiteralPath $moduleManifest -PathType Leaf) -or
    -not (Test-Path -LiteralPath $moduleBinary -PathType Leaf)) {
    throw "ConsoleGuiTools is not built. Run the Release build first, or place this launcher beside the module manifest and DLL."
}

Import-Module $moduleManifest -ErrorAction Stop

Get-Process | Out-ConsoleGridView -OutputMode Multiple -Filter $Filter -Title 'Running processes'
