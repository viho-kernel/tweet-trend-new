pipeline {
    agent { node { label 'maven' } }

    tools {
        jdk 'jdk21'  // Name must match what you configure in Jenkins -> Global Tool Configuration
        maven 'maven3' // Optional, if configured
    }

    environment {
        JAVA_HOME = "/usr/lib/jvm/java-21-openjdk-amd64"
        PATH = "/usr/lib/jvm/java-21-openjdk-amd64/bin:/opt/apache-maven-3.9.5/bin:$PATH"
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