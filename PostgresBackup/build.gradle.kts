plugins {
    id("net.mayope.deployplugin")
}

repositories {
    jcenter()
}

deploy {
    serviceName = "PostgresBackup"
    default {
        helmPush()
    }
}
