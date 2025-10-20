pipeline {
    agent { node { label 'maven' } }

    environment {
        JAVA_HOME = "/usr/lib/jvm/java-21-openjdk-amd64"
        MAVEN_HOME = "/opt/apache-maven-3.9.5"
        PATH = "${JAVA_HOME}/bin:${MAVEN_HOME}/bin:$PATH"
    }

    stages {
        stage('Build') {
            steps {
                sh 'java -version'
                sh 'mvn -version'
                sh 'mvn clean deploy'
            }
        }
    }
}
