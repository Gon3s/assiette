param([Parameter(Mandatory = $true)][string]$Path)

$ErrorActionPreference = 'Stop'
$taskAndroidNamespace = 'http://schemas.android.com/apk/res/android'
$taskSettings = [Xml.XmlReaderSettings]::new()
$taskSettings.DtdProcessing = [Xml.DtdProcessing]::Prohibit
$taskSettings.XmlResolver = $null
$taskReader = [Xml.XmlReader]::Create((Resolve-Path -LiteralPath $Path).Path, $taskSettings)
$taskManifest = [Xml.XmlDocument]::new()
try { $taskManifest.Load($taskReader) } finally { $taskReader.Close() }

$taskPackage = $taskManifest.DocumentElement.GetAttribute('package')
if ($taskPackage -ne 'com.gones.assiette') { throw 'Unexpected Android package' }
$taskAllowedPermissions = @(
    'android.permission.INTERNET',
    'android.permission.ACCESS_COARSE_LOCATION',
    'android.permission.POST_NOTIFICATIONS',
    'android.permission.RECEIVE_BOOT_COMPLETED',
    'android.permission.WAKE_LOCK',
    'android.permission.VIBRATE',
    'android.permission.ACCESS_NETWORK_STATE',
    'com.gones.assiette.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION'
)
$taskPermissions = @($taskManifest.SelectNodes('/manifest/*[starts-with(local-name(), "uses-permission")]') | ForEach-Object { $_.GetAttribute('name', $taskAndroidNamespace) })
foreach ($taskPermission in $taskPermissions) {
    if ($taskPermission -notin $taskAllowedPermissions) { throw "Unexpected permission: $taskPermission" }
}
foreach ($taskRequired in @('android.permission.INTERNET', 'android.permission.ACCESS_COARSE_LOCATION', 'android.permission.POST_NOTIFICATIONS')) {
    if ($taskRequired -notin $taskPermissions) { throw "Required permission missing: $taskRequired" }
}

$taskSignaturePermissions = @(
    'android.permission.BIND_JOB_SERVICE',
    'android.permission.DUMP',
    'com.google.android.gms.auth.api.signin.permission.REVOCATION_NOTIFICATION'
)
foreach ($taskPermission in $taskManifest.SelectNodes('/manifest/permission')) {
    if ($taskPermission.GetAttribute('name', $taskAndroidNamespace) -eq 'com.gones.assiette.DYNAMIC_RECEIVER_NOT_EXPORTED_PERMISSION' -and
        $taskPermission.GetAttribute('protectionLevel', $taskAndroidNamespace) -ne 'signature') {
        throw 'Dynamic receiver permission must be signature-protected'
    }
    if ($taskPermission.GetAttribute('protectionLevel', $taskAndroidNamespace) -eq 'signature') {
        $taskSignaturePermissions += $taskPermission.GetAttribute('name', $taskAndroidNamespace)
    }
}
$taskExported = @()
$taskLauncherFound = $false
foreach ($taskComponent in $taskManifest.SelectNodes('/manifest/application/activity | /manifest/application/activity-alias | /manifest/application/service | /manifest/application/receiver | /manifest/application/provider')) {
    $taskName = $taskComponent.GetAttribute('name', $taskAndroidNamespace)
    $taskExport = $taskComponent.GetAttribute('exported', $taskAndroidNamespace)
    if (-not $taskExport -and $taskComponent.SelectSingleNode('intent-filter')) { throw "Implicit exported component: $taskName" }
    if ($taskExport -ne 'true') { continue }
    $taskPermission = $taskComponent.GetAttribute('permission', $taskAndroidNamespace)
    if ($taskName -eq 'com.gones.assiette.MainActivity' -and $taskComponent.LocalName -eq 'activity') {
        $taskLauncherFound = $true
    } elseif ($taskPermission -notin $taskSignaturePermissions) {
        throw "Unprotected exported component: $taskName"
    }
    $taskExported += [pscustomobject]@{component = $taskName; permission = $taskPermission}
}
if (-not $taskLauncherFound) { throw 'Launcher activity is missing or not exported' }
$taskNamespaces = [Xml.XmlNamespaceManager]::new($taskManifest.NameTable)
$taskNamespaces.AddNamespace('android', $taskAndroidNamespace)
if ($taskManifest.SelectSingleNode('/manifest/application/service[@android:name="com.baseflow.geolocator.GeolocatorLocationService"]', $taskNamespaces)) {
    throw 'Unused foreground location service is still present'
}

[pscustomobject]@{package = $taskPackage; permissions = $taskPermissions; exportedComponents = $taskExported} | ConvertTo-Json -Depth 4
