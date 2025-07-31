pipeline {
    agent any

    environment {
        IMAGE_NAME = "returnick/flask-app"
        IMAGE_TAG = "latest"
        FULL_IMAGE = "${IMAGE_NAME}:${IMAGE_TAG}"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: '6970179e-8739-4f48-968d-fd404b31a95b', branch: 'main', url: 'https://github.com/nkiriazis/flask-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${FULL_IMAGE}"
                    sh "docker build -t ${FULL_IMAGE} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh '''
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker push ${FULL_IMAGE}
                        '''
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker...'
            sh '''
                docker logout || true
                docker rmi ${FULL_IMAGE} || true
            '''
        }
    }
}
