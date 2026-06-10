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
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    val proj = this
    val configureNamespace = {
        val android = proj.extensions.findByName("android")
        if (android != null) {
            try {
                val namespace = android.javaClass.getMethod("getNamespace").invoke(android)
                if (namespace == null) {
                    android.javaClass.getMethod("setNamespace", String::class.java).invoke(android, proj.group.toString())
                }
            } catch (e: Exception) {
                // Ignore
            }
            try {
                val compileSdkMethod = android.javaClass.methods.find { it.name == "compileSdkVersion" && it.parameterCount == 1 }
                compileSdkMethod?.invoke(android, 34)
            } catch (e: Exception) {
                // Ignore
            }
        }
    }
    if (proj.state.executed) {
        configureNamespace()
    } else {
        proj.afterEvaluate { configureNamespace() }
    }
}
