$ErrorActionPreference = 'Stop'
$taskRepository = Split-Path $PSScriptRoot -Parent
$taskScratch = [IO.Path]::GetFullPath((Join-Path $taskRepository '.dart_tool'))
$taskFixture = [IO.Path]::GetFullPath((Join-Path $taskScratch ('release-signing-check-' + [guid]::NewGuid().ToString('N'))))
if (-not $taskFixture.StartsWith($taskScratch + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
    throw 'Signing fixture must stay inside the project scratch directory'
}
$taskWrapper = Join-Path $taskRepository 'android/gradlew.bat'
try {
New-Item -ItemType Directory -Path $taskFixture -Force | Out-Null
$taskGuard = (Join-Path $taskRepository 'android/release-signing.gradle.kts').Replace('\', '/')
[IO.File]::WriteAllText((Join-Path $taskFixture 'settings.gradle.kts'), 'rootProject.name = "signing-guard-check"')
[IO.File]::WriteAllText((Join-Path $taskFixture 'build.gradle.kts'), @"
apply(from = "$taskGuard")
tasks.register("assembleRelease")
tasks.register("bundleRelease")
tasks.register("assembleDebug")
"@)
$taskProperties = Join-Path $taskFixture 'key.properties'
$taskLog = Join-Path $taskFixture 'last-check.log'

function Invoke-SigningCase([string]$CaseName, [string]$TaskName, [bool]$Pass, [string]$Message) {
    $ErrorActionPreference = 'Continue'
    & rtk proxy $taskWrapper --no-daemon --offline --console=plain -q -p $taskFixture $TaskName *> $taskLog
    $taskExit = $LASTEXITCODE
    $ErrorActionPreference = 'Stop'
    $taskOutput = [IO.File]::ReadAllText($taskLog)
    if (($taskExit -eq 0) -ne $Pass -or ($Message -and -not $taskOutput.Contains($Message))) {
        throw "Signing case failed: $CaseName (exit $taskExit)`n$taskOutput"
    }
    Write-Output "PASS: $CaseName"
}

function Set-SigningProperties([string]$Store, [string]$Alias, [string]$Password = 'fixture-password') {
    [IO.File]::WriteAllText($taskProperties, "storeFile=$Store`nstorePassword=$Password`nkeyAlias=$Alias`nkeyPassword=$Password`n")
}

Invoke-SigningCase 'debug without signing config' 'assembleDebug' $true ''
Invoke-SigningCase 'release without signing config' 'assembleRelease' $false 'Release signing configuration is missing'
[IO.File]::WriteAllText($taskProperties, 'keyAlias=publication')
Invoke-SigningCase 'incomplete signing config' 'bundleRelease' $false 'Release signing fields are missing'
Set-SigningProperties 'missing.jks' 'publication'
Invoke-SigningCase 'missing keystore' 'assembleRelease' $false 'Release signing keystore is missing'

$taskKeytool = (Get-Command keytool).Source
$taskErrorPreference = $ErrorActionPreference
$ErrorActionPreference = 'Continue'
& rtk proxy $taskKeytool -genkeypair -alias publication -keyalg RSA -keysize 2048 -validity 1 -dname 'CN=Assiette Signing Fixture' -storetype JKS -keystore (Join-Path $taskFixture 'publication.jks') -storepass fixture-password -keypass fixture-password *> (Join-Path $taskFixture 'keytool.log')
if ($LASTEXITCODE -ne 0) { throw 'Could not generate publication fixture key' }
& rtk proxy $taskKeytool -genkeypair -alias renamed-debug -keyalg RSA -keysize 2048 -validity 1 -dname 'CN=Android Debug,O=Android,C=US' -storetype JKS -keystore (Join-Path $taskFixture 'debug.jks') -storepass fixture-password -keypass fixture-password *> (Join-Path $taskFixture 'keytool.log')
if ($LASTEXITCODE -ne 0) { throw 'Could not generate debug fixture key' }
$ErrorActionPreference = $taskErrorPreference

Set-SigningProperties 'publication.jks' 'androiddebugkey'
Invoke-SigningCase 'debug alias' 'assembleRelease' $false 'A debug key cannot sign a release build'
Set-SigningProperties 'debug.jks' 'renamed-debug'
Invoke-SigningCase 'renamed debug certificate' 'assembleRelease' $false 'Release signing credentials are invalid'
Set-SigningProperties 'publication.jks' 'publication' 'wrong-password'
Invoke-SigningCase 'invalid keystore password' 'assembleRelease' $false 'Release signing credentials are invalid'
Set-SigningProperties 'publication.jks' 'missing'
Invoke-SigningCase 'missing private key alias' 'assembleRelease' $false 'Release signing credentials are invalid'
Set-SigningProperties 'publication.jks' 'publication'
Invoke-SigningCase 'publication key for release' 'assembleRelease' $true ''
Invoke-SigningCase 'publication key for bundle' 'bundleRelease' $true ''
} finally {
    # The resolved absolute directory was checked before creating the fixture.
    if (Test-Path -LiteralPath $taskFixture) {
        Remove-Item -LiteralPath $taskFixture -Recurse -Force
    }
}
