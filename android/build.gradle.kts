allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Some Flutter plugins still declare very old Kotlin Gradle plugin versions in their
    // `android/build.gradle` (Groovy) buildscript classpath. With newer Gradle/AGP, that can
    // lead to missing Kotlin classes on the consumer compile classpath (e.g. plugin class not
    // ending up in bundleLibCompileToJarDebug output).
    //
    // Force a modern Kotlin Gradle plugin version across all subprojects to keep the Android
    // build consistent and avoid "cannot find symbol <PluginClass>" errors in
    // GeneratedPluginRegistrant.java.
    buildscript {
        configurations.configureEach {
            resolutionStrategy.eachDependency {
                if (requested.group == "org.jetbrains.kotlin" &&
                    requested.name == "kotlin-gradle-plugin"
                ) {
                    // Keep this aligned with the root Kotlin plugin version declared in
                    // `android/settings.gradle.kts`.
                    useVersion("2.1.0")
                    because("Align Kotlin Gradle plugin version across Flutter plugin subprojects")
                }
            }
        }
    }

    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
