pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    environment {
        JAVA_HOME = "/usr/lib/jvm/java-21-openjdk-amd64" 
        PATH = "/opt/apache-maven-3.9.5/bin:$PATH"
    }

    stages {
        stage('Build') {
            steps {
                sh '''
                    java -version
                    mvn -version
                    mvn clean deploy
                '''
            }
        }
    }
}
