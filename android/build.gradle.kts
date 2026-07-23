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

subprojects {
    if (project.name != "app") {
        afterEvaluate {
            val androidExt = project.extensions.findByName("android")
            if (androidExt != null) {
                try {
                    androidExt.javaClass.getMethod("setCompileSdk", Int::class.javaPrimitiveType).invoke(androidExt, 36)
                } catch (e: Exception) {
                    try {
                        androidExt.javaClass.getMethod("setCompileSdkVersion", Int::class.javaPrimitiveType).invoke(androidExt, 36)
                    } catch (ignored: Exception) {}
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
