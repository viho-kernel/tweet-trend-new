pipeline {
    agent { node { label 'maven' } }

    stages {
        stage('Build') {
            steps {
                sh '''
                    export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
                    export PATH=$JAVA_HOME/bin:/opt/apache-maven-3.9.5/bin:$PATH
                    echo "JAVA_HOME is $JAVA_HOME"
                    java -version
                    mvn -version
                    mvn clean deploy
                '''
            }
        }
    }
}
