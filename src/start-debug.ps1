param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ArgsList
)

$scriptPath = Join-Path $PSScriptRoot "start.ps1"
& $scriptPath --offline-logging --debug --debug-server-connect @ArgsList
exit $LASTEXITCODE
