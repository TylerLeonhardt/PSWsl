param(
    [Parameter(Mandatory=$true)]
    [string]
    $GalleryApiKey
)

.\build.ps1 -Test -Package

$currentPSModulePath = $env:PSModulePath
$env:PSModulePath = $env:PSModulePath + [System.IO.Path]::PathSeparator + "$PSScriptRoot\out\PSWsl"

Publish-Module -Name PSWsl -NuGetApiKey $GalleryApiKey