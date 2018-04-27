# PSWsl

[![Build status](https://ci.appveyor.com/api/projects/status/d9gpxqarsca9pa3o/branch/master?svg=true)](https://ci.appveyor.com/project/PowerShell/pswsl/branch/master)

PSWsl is a PowerShell module for interacting with WSL. If PowerShell Core exists on your WSL distibution, you can easily invoke commands that return deserialized objects:

```powershell
PS > $versionHashTable = Invoke-WslCommand -Distribution debian -Command '$PSVersionTable'
PS > $versionHashTable.PSVersion
6.0.2
``` 

This module simply wraps the wsl.exe, wslconfig.exe, and all the distribution.exe's in a more PowerShell friendly/specific way.

## Installation

PSWsl is available on the PowerShell Gallery:

```powershell
Install-Module PSWsl
```

You can also grab the latest zip from GitHub and put that in your `$env:PSModulePath` under a `PSWsl` folder.

## Usage

If you don't have PSWsl in your PSModulePath, you will need to import it manually with:

```powershell
Import-Module path/to/your/PSWsl/PSWsl.psd1
```

From there you should be able to enter into PSSessions in WSL, invoke commands from your current session of PowerShell, get your distributions, and set the default distribution:

### Enter into a PSSession in a WSL distribution

```powershell
# use your default distribution
Enter-WslDistribution

# be specific
Enter-WslDistribution -DistributionName ubuntu
```

### Invoke commands within a WSL distribution

```powershell
# You can use a string command, script block, or file. You can also pipe in a distribution array
PS > $versionHashTable = Invoke-WslCommand -Distribution debian -ScriptBlock { $PSVersionTable }
PS > $versionHashTable.Platform
Unix
```

### Get your distributions

```powershell
# Get all
Get-WslDistribution

# Supports wildcards
Get-WslDistribution -DistributionName ubunt*

# Piping
Get-WslDistribution | Invoke-WslCommand -Command '$PSVersionTable'
```

### Set the default distribution

```powershell
# explicit
Set-DistributionDefault -DistributionName ubuntu

# Piping
Get-WslDistribution -DistributionName ubun* | Set-DistributionDefault
```

## Running the tests

The Pester tests use mocks to mock specific executables so you shouldn't need any setup.

Just run `Invoke-Pester` from the `test` directory.
