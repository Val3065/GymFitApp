import org.gradle.api.tasks.Delete
import org.gradle.api.file.Directory

// =====================
// Repositorios comunes
// =====================
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// =====================
// Configuración del build directory
// =====================
// Mantener dentro del proyecto para evitar problemas de permisos
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)
}

// =====================
// Evaluación de subproyectos
// =====================
subprojects {
    project.evaluationDependsOn(":app")
}

// =====================
// Task clean personalizado
// =====================
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// =====================
// Buildscript para Google Services (Firebase)
// =====================
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Última versión estable de google-services
        classpath("com.google.gms:google-services:4.4.3")
    }
}

