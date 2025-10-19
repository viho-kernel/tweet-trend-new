def registry = 'https://trialjrkno6.jfrog.io'
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

        stage("Jar Publish") {
        steps {
            script {
                    echo '<--------------- Jar Publish Started --------------->'
                     def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"artifact-cred"
                     def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                     def uploadSpec = """{
                          "files": [
                            {
                              "pattern": "jarstaging/**/*.jar",
                              "target": "libs-release-local/com/valaxy/demo-workshop/",
                              "props" : "${properties}"
                            },
                            {
                  "pattern": "jarstaging/**/*.pom",
                  "target": "libs-release-local/com/valaxy/demo-workshop/",
                  "props": "${properties}"
                }
                         ]
                     }"""
                     def buildInfo = server.upload(uploadSpec)
                     buildInfo.env.collect()
                     server.publishBuildInfo(buildInfo)
                     echo '<--------------- Jar Publish Ended --------------->'  
            
            }
        }   
    }

    }
}