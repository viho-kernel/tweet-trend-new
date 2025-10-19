pipeline {
    agent {
        node {
            label 'maven'
        }
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

        stage('SonarQube analysis') {
            environment {
                scannerHome = tool 'valaxy-sonar-Scanner'
            }
            steps {
                withSonarQubeEnv('valaxy-sonarQube') {
                    sh "${scannerHome}/bin/sonar-scanner"
            }

            }
        }
    }
}