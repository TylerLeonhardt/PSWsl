#!/usr/bin/env pwsh

param(
    [Parameter()]
    [switch]
    $Bootstrap,

    [Parameter()]
    [switch]
    $Test,

    [Parameter()]
    [switch]
    $Package
)

$NeededTools = @{
    PowerShellCore = "PowerShell Core 6.0.0 or greater"
    Pester = "Pester latest"
}

function needsPowerShellCore () {
    try {
        $powershellverison = (pwsh -v)
    } catch {
        return $true
    }
    return $false
}

function needsPester() {
    if (Get-Module -ListAvailable -Name Pester) {
        return $false
    }
    return $true
}

function getMissingTools () {
    $missingTools = @()

    if (needsPowerShellCore) {
        $missingTools += $NeededTools.PowerShellCore
    }

    if (needsPester) {
        $missingTools += $NeededTools.Pester
    }

    return $missingTools
}

function hasMissingTools () {
    return ((getMissingTools).Count -gt 0)
}

if ($Bootstrap) {
    $string = "Here is what your environment is missing:`n"
    $missingTools = getMissingTools
    
    if (($missingTools).Count -eq 0) {
        $string += "* nothing!`n`n Run this script without a flag to build or a -Clean to clean."
    } else {
        $missingTools | ForEach-Object {$string += "* $_`n"}
    }
    
    Write-Host "`n$string`n"
} elseif(hasMissingTools) {
    Write-Host "You are missing needed tools. Run './build.ps1 -Bootstrap' to see what they are."
} else {
    if($Test) {
        Push-Location $PSScriptRoot\test
        Invoke-Pester
        Pop-Location
    }

    if ($Package) {
        if ((Test-Path "$PSScriptRoot\out")) {
            Remove-Item -Path $PSScriptRoot\out -Recurse -Force
        }

        New-Item -ItemType directory -Path $PSScriptRoot\out

        New-Item -ItemType directory -Path $PSScriptRoot\out\PSWsl
        Copy-Item -Path "$PSScriptRoot\PSWsl.ps*1" -Destination "$PSScriptRoot\out\PSWsl\" -Force

        Copy-Item -Path "$PSScriptRoot\README.md" -Destination "$PSScriptRoot\out\PSWsl\" -Force
        Copy-Item -Path "$PSScriptRoot\LICENSE" -Destination "$PSScriptRoot\out\PSWsl\" -Force
    }
}
