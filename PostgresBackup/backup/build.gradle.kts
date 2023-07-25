plugins {
    id("net.mayope.deployplugin")
}

repositories {
    jcenter()
}
deploy {
    serviceName = "postgres-ssh-backup"
    default {

        dockerLogin {
            registryRoot = "https://index.docker.io/v1/"
        }
        dockerPush {
            registryRoot = "mayope"
        }
        dockerBuild {
            prepareTask = "prepareDocker"
            dockerDir = "src/docker"
        }
        dockerPush()
    }
}
tasks.register("build")
tasks.register("prepareDocker")
