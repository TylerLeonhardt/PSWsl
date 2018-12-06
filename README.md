# PSWsl

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/15de432502014297af5d77cc46a01251)](https://app.codacy.com/app/TylerLeonhardt/PSWsl?utm_source=github.com&utm_medium=referral&utm_content=TylerLeonhardt/PSWsl&utm_campaign=Badge_Grade_Settings)
[![Build status](https://ci.appveyor.com/api/projects/status/d9gpxqarsca9pa3o/branch/master?svg=true)](https://ci.appveyor.com/project/PowerShell/pswsl/branch/master)
![Core compatible](https://img.shields.io/badge/PowerShell%20Core-Compatible-blue.svg?logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPD94bWwgdmVyc2lvbj0iMS4wIj8%2BCjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgMzIgMzIiIHdpZHRoPSIzMnB4IiBoZWlnaHQ9IjMycHgiPgogICAgPHBhdGggc3R5bGU9ImxpbmUtaGVpZ2h0Om5vcm1hbDt0ZXh0LWluZGVudDowO3RleHQtYWxpZ246c3RhcnQ7dGV4dC1kZWNvcmF0aW9uLWxpbmU6bm9uZTt0ZXh0LWRlY29yYXRpb24tc3R5bGU6c29saWQ7dGV4dC1kZWNvcmF0aW9uLWNvbG9yOiNGRkY7dGV4dC10cmFuc2Zvcm06bm9uZTtibG9jay1wcm9ncmVzc2lvbjp0Yjtpc29sYXRpb246YXV0bzttaXgtYmxlbmQtbW9kZTpub3JtYWwiIGQ9Ik0gOC4wNjgzNTk0IDUgQyA3LjU5ODU0NzggNSA3LjA3NDAwODUgNS4wNzA2MDQyIDYuNjM0NzY1NiA1LjQyNzczNDQgQyA2LjE5NTUyMjcgNS43ODQ4NjQ1IDYuMDE4Mjk5MyA2LjI4MDA3NTYgNS45MTYwMTU2IDYuNzQ0MTQwNiBDIDQuNjMxOTkyNCAxMi42MDcyNDcgMy4zNDg0Mjk0IDE4LjQ3MDg3OCAyLjA2NjQwNjIgMjQuMzMzOTg0IEwgMi4wNjY0MDYyIDI0LjMzNTkzOCBDIDEuOTMxODU2NiAyNC45NTY5MzYgMS45OTQwNDUyIDI1LjYzNTI2OCAyLjM4NDc2NTYgMjYuMTc1NzgxIEMgMi43NzU0ODU4IDI2LjcxNjI0OSAzLjQ1OTEyNDEgMjcgNC4xMjUgMjcgTCAyNCAyNyBDIDI0LjUxNDQ1NSAyNyAyNS4wNzMwMyAyNi44MjAwMDQgMjUuNDQ3MjY2IDI2LjQ1MTE3MiBDIDI1LjgyMTUwMiAyNi4wODIzNCAyNS45Nzk4NDUgMjUuNjM0NzI2IDI2LjA3MjI2NiAyNS4yMTI4OTEgTCAyNi4wNzIyNjYgMjUuMjEwOTM4IEMgMjcuMzYxMzE3IDE5LjMxOTc1IDI4LjY0NzU3MiAxMy40Mjc0NzMgMjkuOTMxNjQxIDcuNTM1MTU2MiBDIDMwLjA2MzE4NyA2LjkzMTQ2NjEgMzAuMDE5OTc1IDYuMjQ0NDIwNCAyOS41OTU3MDMgNS43MTY3OTY5IEMgMjkuMTcxNDMyIDUuMTg5MTczMyAyOC41MDk2MzQgNSAyNy44OTY0ODQgNSBMIDguMDY4MzU5NCA1IHogTSA4LjA2ODM1OTQgNyBMIDI3Ljg5NjQ4NCA3IEMgMjcuOTU5NjE3IDcgMjcuOTYyNTYgNy4wMDQzMTMxIDI3Ljk5MjE4OCA3LjAwNzgxMjUgQyAyNy45ODkzNDIgNy4wMzg1NTU1IDI3Ljk5MjcxIDcuMDQ0Mjc2MiAyNy45Nzg1MTYgNy4xMDkzNzUgQyAyNi42OTQ1ODUgMTMuMDAxMDU4IDI1LjQwNjEzNiAxOC44OTQzOSAyNC4xMTcxODggMjQuNzg1MTU2IEwgMjQuMTE5MTQxIDI0Ljc4MzIwMyBDIDI0LjA3NjUwMyAyNC45Nzc4MTEgMjQuMDQwNTM5IDI1LjAxMDYgMjQuMDUwNzgxIDI1LjAwMTk1MyBDIDI0LjAzODkwNiAyNS4wMDEzMTggMjQuMDQzNDc5IDI1IDI0IDI1IEwgNC4xMjUgMjUgQyAzLjkzNjg3NTkgMjUgMy45ODgxMzkyIDI0Ljk3OTM5NiA0LjAwNTg1OTQgMjUuMDAzOTA2IEMgNC4wMjM0Mzg0IDI1LjAyODIyNiAzLjk3NDAwMzMgMjQuOTc2Mjg2IDQuMDE5NTMxMiAyNC43NjE3MTkgTCA0LjAxOTUzMTIgMjQuNzU5NzY2IEMgNS4zMDEzNzIzIDE4Ljg5NzU0NiA2LjU4NTI5OTkgMTMuMDM2MTAxIDcuODY5MTQwNiA3LjE3MzgyODEgQyA3Ljg5MTM2OTQgNy4wNzI5NzUzIDcuOTA1NjAxIDcuMDQzNTI2NiA3LjkxNzk2ODggNy4wMDk3NjU2IEMgNy45NTEwODQ2IDcuMDA1NzMyNyA3Ljk3NDgzNTcgNyA4LjA2ODM1OTQgNyB6IE0gMTEuNTMzMjAzIDcuOTg0Mzc1IEEgMS41MDAxNSAxLjUwMDE1IDAgMCAwIDEwLjQwNjI1IDEwLjUyNTM5MSBMIDE1LjI1IDE1LjY5NTMxMiBMIDcuNjEzMjgxMiAyMS4yOTEwMTYgQSAxLjUwMDE1IDEuNTAwMTUgMCAxIDAgOS4zODY3MTg4IDIzLjcwODk4NCBMIDE4LjM4NjcxOSAxNy4xMTUyMzQgQSAxLjUwMDE1IDEuNTAwMTUgMCAwIDAgMTguNTkzNzUgMTQuODc4OTA2IEwgMTIuNTkzNzUgOC40NzQ2MDk0IEEgMS41MDAxNSAxLjUwMDE1IDAgMCAwIDExLjUzMzIwMyA3Ljk4NDM3NSB6IE0gMTUuNSAyMSBBIDEuNTAwMTUgMS41MDAxNSAwIDEgMCAxNS41IDI0IEwgMTkuNSAyNCBBIDEuNTAwMTUgMS41MDAxNSAwIDEgMCAxOS41IDIxIEwgMTUuNSAyMSB6IiBmaWxsPSIjRkZGIiBmb250LXdlaWdodD0iNDAwIiBmb250LWZhbWlseT0ic2Fucy1zZXJpZiIgd2hpdGUtc3BhY2U9Im5vcm1hbCIgb3ZlcmZsb3c9InZpc2libGUiLz4KPC9zdmc%2B)

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

## Why?

* Quickly test scripts and modules against linux without having to stand up a VM or container.
* Write multi-OS scripts that leverage PowerShell on Windows while also interacting with a Linux environment.
* Interact with Linux-only tools and utilities with PowerShell.

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
