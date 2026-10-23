import java.security.KeyStore
import java.security.cert.X509Certificate
import java.util.Properties

// Kept separate so the guard can also be exercised without Android tooling.
val validateReleaseSigning = tasks.register("validateReleaseSigning") {
    group = "verification"
    description = "Reject missing, invalid or debug signing credentials for release builds."
    doLast {
        val instructions = "Configure android/key.properties with storeFile (relative to android/app), " +
            "storePassword, keyAlias and keyPassword for the publication keystore."
        val propertiesFile = rootProject.file("key.properties")
        if (!propertiesFile.isFile) {
            throw GradleException("Release signing configuration is missing. $instructions")
        }
        val properties = Properties()
        try {
            propertiesFile.inputStream().use { properties.load(it) }
        } catch (_: Exception) {
            throw GradleException("Release signing configuration cannot be read. $instructions")
        }
        val required = listOf("storeFile", "storePassword", "keyAlias", "keyPassword")
        val missing = required.filter { properties.getProperty(it).isNullOrBlank() }
        if (missing.isNotEmpty()) {
            throw GradleException("Release signing fields are missing: ${missing.joinToString()}. $instructions")
        }
        val keystoreFile = project.file(properties.getProperty("storeFile"))
        if (!keystoreFile.isFile) {
            throw GradleException("Release signing keystore is missing. $instructions")
        }
        val alias = properties.getProperty("keyAlias")
        if (alias.equals("androiddebugkey", ignoreCase = true)) {
            throw GradleException("A debug key cannot sign a release build. $instructions")
        }
        try {
            val keystore = KeyStore.getInstance(
                keystoreFile,
                properties.getProperty("storePassword").toCharArray(),
            )
            val certificate = keystore.getCertificate(alias) as? X509Certificate
            val subject = certificate?.subjectX500Principal?.name.orEmpty()
            if (!keystore.isKeyEntry(alias) || certificate == null ||
                Regex("(^|,)CN=Android Debug(,|$)", RegexOption.IGNORE_CASE).containsMatchIn(subject) ||
                keystore.getKey(alias, properties.getProperty("keyPassword").toCharArray()) == null
            ) {
                throw IllegalArgumentException()
            }
        } catch (_: Exception) {
            // Do not include the cause: provider errors can contain credential data.
            throw GradleException("Release signing credentials are invalid or use a debug certificate. $instructions")
        }
    }
}

// Covers assemble/bundle and abbreviated task requests, including future flavors.
// Debug builds and IDE sync do not execute the guard.
tasks.configureEach {
    if (name != "validateReleaseSigning" && name.contains("Release", ignoreCase = true)) {
        dependsOn(validateReleaseSigning)
    }
}
