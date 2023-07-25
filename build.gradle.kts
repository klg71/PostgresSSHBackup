plugins {

    id("net.mayope.deployplugin") version "0.0.63"
}

repositories {
    mavenCentral()
}

deployDefault {
    fun Project.loadFromSettingsGradle(key: String) =
        project.findProperty(key) as String? ?: error(
            "You have to set $key in settings.gradle before using this project"
        )

    default {
        dockerBuild()
        dockerLogin {
            registryRoot = "https://index.docker.io/v1/"
            loginMethod = net.mayope.deployplugin.tasks.DockerLoginMethod.CLASSIC
            loginUsername = project.loadFromSettingsGradle("dockerHubRegistryUser")
            loginPassword = project.loadFromSettingsGradle("dockerHubRegistryPassword")
        }
        dockerPush {
            registryRoot = "mayope"
            loginMethod = net.mayope.deployplugin.tasks.DockerLoginMethod.CLASSIC
            loginUsername = project.loadFromSettingsGradle("dockerHubRegistryUser")
            loginPassword = project.loadFromSettingsGradle("dockerHubRegistryPassword")
        }

        helmPush {
            val chartmuseumPass = project.findProperty("chartMuseumPassword") as String? ?: error(
                "chartMuseumPassword is not set in gradle properties"
            )
            repositoryUrl = "https://charts.mayope.net"
            repositoryUsername = "mayope"
            repositoryPassword = chartmuseumPass
        }
    }
}

