# PSWsl

[![Build status](https://ci.appveyor.com/api/projects/status/d9gpxqarsca9pa3o/branch/master?svg=true)](https://ci.appveyor.com/project/PowerShell/pswsl/branch/master)

PSWsl is a PowerShell module for interacting with WSL. If PowerShell Core exists on your WSL distibution, you can easily invoke commands that return deserialized objects:

In PowerShell Core on Windows
```powershell
PS > $versionHashTable = Invoke-WslCommand -Distribution debian -Command '$PSVersionTable'
PS > $versionHashTable.Platform
Unix
``` 

Demo:
![invoke-wslcommand](https://user-images.githubusercontent.com/2644648/39400721-d037036c-4aea-11e8-87e7-608de8fc4ca7.gif)

This module simply wraps the wsl.exe, wslconfig.exe, and all the distribution.exe's in a more PowerShell friendly/specific way.

## Installation

> Note: To get PowerShell Core on your WSL distribution, follow the steps [here](https://github.com/powershell/powershell#get-powershell).

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

![enter-wsldistribution](https://user-images.githubusercontent.com/2644648/39400720-d0207aca-4aea-11e8-9f5c-6fb9b14953ff.gif)

```powershell
# use your default distribution
Enter-WslDistribution

# be specific
Enter-WslDistribution -DistributionName ubuntu
```

### Invoke commands within a WSL distribution

![invoke-wslcommand](https://user-images.githubusercontent.com/2644648/39400721-d037036c-4aea-11e8-87e7-608de8fc4ca7.gif)

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
