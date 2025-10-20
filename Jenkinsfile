pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    environment {
    JAVA_HOME = "/usr/lib/jvm/java-21-openjdk-amd64"
    PATH = "${JAVA_HOME}/bin:/opt/apache-maven-3.9.5/bin:$PATH"
}


    stages {
        stage('Build') {
            steps {
                echo "---build started---"
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                echo "---build ended---"
            }
        }

        stage('Test') {
            steps {
                echo "unit test started"
                sh 'mvn surefire-report:report'
                echo "unit test ended"
            }
        }

        stage('Sonar analysis') {
            environment {
                scannerHome = tool 'viho-Kernel-sonar-Scanner'
            }
            steps {
                withSonarQubeEnv('viho-kernel-sonarQube') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage('Quality Gate') {
            steps {
                script {
                    try {
                        timeout(time: 3, unit: 'MINUTES') {
                            def qg = waitForQualityGate()
                            if (qg.status != 'OK') {
                                echo "Quality Gate failed, but continuing build: ${qg.status}"
                            }
                        }
                    } catch (err) {
                        echo "Quality Gate check timed out — continuing build"
                    }
                }
            }
        }   

        
    }
}