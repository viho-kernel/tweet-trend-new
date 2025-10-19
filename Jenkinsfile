pipeline {
    agent {
        node {
            label 'maven'
        }
    }
environment {
        PATH = "/opt/apache-maven-3.9.5/bin:$PATH"
    }

    stages {
        stage('check Java version') {
            steps {
                sh 'java -version'
                sh 'echo $JAVA_HOME'
                sh 'mvn -version'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean deploy'
            }
        }
    }
}

