$RootPath = Split-Path -Parent $MyInvocation.MyCommand.Path | Split-Path

$Instances = @(@((Get-ChildItem $RootPath -filter '*.py' -Recurse).FullName) | Where-Object {$_ -ne $null})

if ($Instances.Count -eq 0)
{
    Write-Output 'No JSON files found in this folder'
}
else
{
    ## Create an empty array
    $TestCases = @()
    $Instances.ForEach{$TestCases += @{Instance = $_}}
    Describe 'Testing all python files' {

        Context "Check for zero length files" {
            It "<Instance> file is greater than 0" -TestCases $TestCases {
                Param($Instance)
                (Get-ChildItem $Instance -Verbose).Length | Should BeGreaterThan 0
            }    
        }

        Context "Run PYLINT on python files" {
            It "<Instance> has no pylint warnings" -TestCases $TestCases {
                Param($Instance)
                $pylint = (pylint ($Instance) -f json --persistent=n --score=y) | ConvertFrom-Json

                $pylint | ForEach-Object {

                    Write-Warning ('Line: {0} is {1}[{2}] in {3}' -f $_.line, $_.message, $_.('message-id'), $_.path)
                }

                ($pylint.count) | should be 0
            }
        }
    }
}