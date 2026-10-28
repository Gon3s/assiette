# Select the CI-pinned SDK without changing the machine or user configuration.
# Usage: rtk powershell -NoProfile -ExecutionPolicy Bypass -File tool/flutter.ps1 --version
# Add -Dart before the arguments to run Dart from that same SDK.
param(
    [switch] $Dart,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]] $FlutterArguments
)

$ErrorActionPreference = 'Stop'
$taskRoot = Split-Path -Parent $PSScriptRoot
$taskWorkflow = Get-Content -LiteralPath (Join-Path $taskRoot '.github/workflows/android-debug-apk.yml') -Raw
$taskPlayWorkflow = Get-Content -LiteralPath (Join-Path $taskRoot '.github/workflows/android-play-internal.yml') -Raw
$taskVersion = [regex]::Match($taskWorkflow, "flutter-version: '([^']+)'").Groups[1].Value
$taskPlayVersion = [regex]::Match($taskPlayWorkflow, "flutter-version: '([^']+)'").Groups[1].Value
if (!$taskVersion -or $taskVersion -ne $taskPlayVersion) {
    throw 'Flutter CI pins are missing or disagree.'
}

$taskFlutter = (Get-Command flutter -ErrorAction Stop).Source
$taskCurrentRoot = Split-Path -Parent (Split-Path -Parent $taskFlutter)
$taskCandidates = @(
    $env:FLUTTER_ROOT
    (Join-Path (Split-Path -Parent $taskCurrentRoot) "flutter-$taskVersion")
    $taskCurrentRoot
)
$taskSdk = $taskCandidates | Where-Object {
    if (!$_) { return $false }
    $taskMetadata = Join-Path $_ 'bin/cache/flutter.version.json'
    (Test-Path -LiteralPath $taskMetadata) -and
        ((Get-Content -LiteralPath $taskMetadata -Raw | ConvertFrom-Json).frameworkVersion -eq $taskVersion)
} | Select-Object -First 1
if (!$taskSdk) {
    throw "Flutter $taskVersion is not installed. Set FLUTTER_ROOT to that SDK."
}

$env:FLUTTER_ROOT = $taskSdk
$env:Path = (Join-Path $taskSdk 'bin') + ';' + $env:Path
if ($Dart) {
    & rtk dart @FlutterArguments
} else {
    & rtk flutter @FlutterArguments
}
exit $LASTEXITCODE
