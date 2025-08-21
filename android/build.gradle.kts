plugins {
    // ...

    // Add the dependency for the Google services Gradle plugin
    id("com.google.gms.google-services") version "4.4.3" apply false

}
/* ✅ Step 1: Add this block at the top of the file
buildscript {
    repositories {
        google()         // ✅ Required for Firebase plugin
        mavenCentral()   // ✅ Optional, but safe
    }
    dependencies {
        classpath("com.google.gms:google-services:4.4.1")
    }
}*/

// ✅ Step 2: Keep your original content below this
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
