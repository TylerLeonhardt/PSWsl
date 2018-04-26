<#
.SYNOPSIS
Run some PowerShell on your WSL Distributions.

.DESCRIPTION
Run some PowerShell on your WSL Distributions.

.PARAMETER DistributionName
The distribution of WSL you want to run against.

.PARAMETER Command
The PowerShell command you want to run.

.PARAMETER Scriptblock
The PowerShell script block you want to run.

.PARAMETER ScriptPath
The PowerShell script file you want to run.

.PARAMETER Sudo
A switch to decide whether you run pwsh with sudo.

.EXAMPLE
Invoke-WslCommand -Scriptblock { $PSVersionTable } # uses default wsl.exe

.EXAMPLE
Invoke-WslCommand -Command '$PSVersionTable'

.EXAMPLE
Invoke-WslCommand -ScriptFile ./foo.ps1

.EXAMPLE
Invoke-WslCommand -Scriptblock { $PSVersionTable } -Distribution debian # uses debian.exe

.EXAMPLE
$version = Invoke-WslCommand -Scriptblock { $PSVersionTable }
$version.GetType() # you get back a deserialized object from the invocation

.NOTES
You must have pwsh and the WSL distribution installed already.
#>
function Invoke-WslCommand {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string[]]
        $DistributionName = @("wsl"),

        [Parameter(Mandatory=$true, ParameterSetName="Command", ValueFromPipelineByPropertyName=$true)]
        [string]
        $Command,

        [Parameter(Mandatory=$true, ParameterSetName="ScriptBlock", ValueFromPipelineByPropertyName=$true)]
        [scriptblock]
        $Scriptblock,

        [Parameter(Mandatory=$true, ParameterSetName="ScriptPath", ValueFromPipelineByPropertyName=$true)]
        [string]
        $ScriptPath,

        [Parameter()]
        [switch]
        $Sudo
    )

    begin {}
    process {
        # Test if distribution exists
        where.exe $DistributionName | Out-Null
        if ($LASTEXITCODE -eq 1) {
            throw "Could not find distribution: $DistributionName"
        }

        # Start with pwsh template. Command will go on the right, WSL invocation will go on the left
        $commandString = "pwsh -OutputFormat xml -EncodedCommand "
    
        # We convert the script into a base64 string so we can easily pass it to the pwsh process in WSL
        switch ($PSCmdlet.ParameterSetName) {
            Command {
                $commandString += [convert]::tobase64string([text.encoding]::unicode.getbytes($Command))
            }
            Scriptblock {
                $commandString += [convert]::tobase64string([text.encoding]::unicode.getbytes($Scriptblock.ToString()))
            }
            ScriptPath {
                if (-not (Test-Path $ScriptPath)) {
                    throw "No path found: $ScriptPath"
                }
                $commandString += [convert]::tobase64string([text.encoding]::unicode.getbytes(". $ScriptPath"))
            }
        }

        # If the you want to run pwsh with sudo, add 'sudo'
        if ($Sudo) {
            $commandString = "sudo $commandString"
        }

        # wsl.exe and specific_distro.exe have a different API. The Specific distros have a run command that you
        # put your command after, wsl.exe does not have said 'run' command so we need to factor that into our string
        if (!$DistributionName.Trim().ToLower().Equals("wsl")) {
            $commandString = "run $commandString"
        }

        # Add the distribution
        $commandString = "$DistributionName $commandString"

        Write-Verbose "Running: $commandString"
        return (Invoke-Expression $commandString)
    }
    end {}
}

<#
.SYNOPSIS
Get the WSL distribution objects. Supports wildcards.

.DESCRIPTION
Get the WSL distribution objects. Supports wildcards. Wraps wslconfig.exe

.PARAMETER DistributionName
The distribution of WSL you want to get. Supports wildcard.

.PARAMETER Default
Get the default WSL distribution

.EXAMPLE
Get-WslDistribution # get all distros

.EXAMPLE
Get-WslDistribution -Default # get the default distro

.EXAMPLE
# pipe it into something else
Get-WslDistribution -DistributionName "ubun*" | Set-WslDistributionDefault

.EXAMPLE
# pipe an array into it
@("ubun*", "debian") | Get-WslDistribution

.NOTES
You must have the WSL distribution installed already.
#>
function Get-WslDistribution {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true)]
        [string[]]
        $DistributionName = "*",

        [Parameter()]
        [switch]
        $Default
    )
    
    begin {
        # parse
        $array = [System.Text.Encoding]::Unicode.GetString([System.Text.Encoding]::UTF8.GetBytes((wslconfig.exe /l))).Split("   ", [System.StringSplitOptions]::RemoveEmptyEntries) | Select-Object -Skip 1 -Unique

        $distributionArray = $array | ForEach-Object {
            if ($_.Contains(' (Default)')) {
                return [PSCustomObject]@{
                    DistributionName = $_.Split(" (Default)", [System.StringSplitOptions]::RemoveEmptyEntries)[0]
                    Default = $true
                }
            } else {
                return [PSCustomObject]@{
                    DistributionName = $_
                    Default = $false
                }
            }
        }
    }
    
    process {
        $Filter = [scriptblock]::Create( (
            '( ' + ( $DistributionName.ForEach( { "`$_.DistributionName   -like `"$_`"" } ) -join ' -or ' ) + ' )') )
        
        if ($Default) {
            return $distributionArray.Where( { $_.Default } )
        } else {
            return $distributionArray.Where( $Filter )
        }
    }
    
    end {}
}

<#
.SYNOPSIS
Set the default WSL distribution.

.DESCRIPTION
Set the default WSL distribution. Wraps wslconfig.exe.

.PARAMETER DistributionName
The name of the WSL distribution you want to make the default.

.PARAMETER Distribution
The distribution of WSL you want to make the default.

.EXAMPLE
Set-WslDistribution -DistributionName Ubuntu # get all distros

.EXAMPLE
# pipe it into something else
Get-WslDistribution -DistributionName "ubun*" | Set-WslDistributionDefault

.NOTES
You must have the WSL distribution installed already.
#>
function Set-WslDistributionDefault {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ParameterSetName="DistributionName")]
        [string]
        $DistributionName,

        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ParameterSetName="DistributionObject")]
        [PSCustomObject]
        $Distribution
    )
    
    begin {}
    process {
        switch ($PSCmdlet.ParameterSetName) {
            DistributionName {
                wslconfig.exe /s $DistributionName
            }
            DistributionObject {
                wslconfig.exe /s $Distribution.DistributionName
            }
        }
    }
    end {}
}

<#
.SYNOPSIS
Enter a PowerShell session within a WSL distribution.

.DESCRIPTION
Enter a PowerShell session within a WSL distribution.

.PARAMETER DistributionName
The name of the WSL distribution you want to make the default.

.PARAMETER Distribution
The distribution of WSL you want to make the default.

.EXAMPLE
Enter-WslDistribution -DistributionName Ubuntu # get all distros

.EXAMPLE
# pipe it into something else
Get-WslDistribution -DistributionName "ubun*" | Enter-WslDistribution

.NOTES
You must have the WSL distribution installed already.
#>
function Enter-WslDistribution {
    [CmdletBinding(DefaultParameterSetName="DistributionName")]
    param (
        [Parameter(ValueFromPipeline=$true, ParameterSetName="DistributionName")]
        [string]
        $DistributionName = "*",

        [Parameter(ValueFromPipeline=$true, ParameterSetName="DistributionObject")]
        [PSCustomObject]
        $Distribution
    )
    
    begin {
    }
    
    process {
        switch ($PSCmdlet.ParameterSetName) {
            DistributionName {
                $distro = Get-WslDistribution -DistributionName $DistributionName
                if (-not $distro) {
                    throw "Could not find distribution: $DistributionName"
                } else {
                    Invoke-Expression "$($distro[0].DistributionName) run pwsh"
                }
            }
            DistributionObject {
                Invoke-Expression "$($Distribution.DistributionName) run pwsh"
            }
        }
    }
    
    end {
    }
}