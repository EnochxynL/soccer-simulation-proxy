param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ArgsList
)

$scriptPath = Join-Path $PSScriptRoot "start.ps1"
& $scriptPath --offline-client-mode --debug --debug-server-logging @ArgsList
exit $LASTEXITCODE
