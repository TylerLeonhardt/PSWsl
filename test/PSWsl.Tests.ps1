Import-Module $PSScriptRoot\..\PSWsl.psd1

Describe "PSWsl tests" {
    Context "Get-WslDistribution tests" {
        BeforeAll {
            $text = "Windows Subsystem for Linux Distributions:
Ubuntu (Default)
Debian"
            # wslconfig.exe /l returns unicode so we need to do some encoding to get it right
            $unicodeStr = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Unicode.GetBytes($text))
            Mock -CommandName "wslconfig.exe" -MockWith { 
                return $unicodeStr 
            }
        }
        It "Can get all distributions" {
            Write-Host (Get-WslDistribution | Out-String)
            (Get-WslDistribution).Count | Should -Be 2
        }
        It "Can get your distribution" {
            $result = (Get-WslDistribution -DistributionName ubuntu)[0]
            $result.distributionName | Should -Be 'Ubuntu'
            $result.Default | Should -BeTrue
        }
        It "Can get your distribution using wildcard" {
            $result = (Get-WslDistribution -DistributionName deb*)[0]
            $result.distributionName | Should -Be 'Debian'
            $result.Default | Should -BeFalse
        }
        It "Can get your default distribution" {
            $result = (Get-WslDistribution -Default)[0]
            $result.distributionName | Should -Be 'Ubuntu'
            $result.Default | Should -BeTrue
        }
    }
}

