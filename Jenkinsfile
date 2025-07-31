pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "flask-app"
        DOCKER_REPOSITORY = "returnick/${DOCKER_IMAGE_NAME}"
        BUILD_TAG = "${env.TAG_NAME ?: 'latest'}"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'fb7cfa46-83f2-465b-b866-1627b1966877', // GitHub token credential ID
                    branch: 'main',
                    url: 'https://github.com/nkiriazis/flask-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def fullImageTag = "${DOCKER_REPOSITORY}:${BUILD_TAG}"
                    echo "Building Docker image: ${fullImageTag}"
                    docker.build(fullImageTag, "--pull .")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    def fullImageTag = "${DOCKER_REPOSITORY}:${BUILD_TAG}"
                    docker.withRegistry('https://registry.hub.docker.com', '6970179e-8739-4f48-968d-fd404b31a95b') { // Docker Hub credentials ID
                        echo "Pushing Docker image: ${fullImageTag}"
                        docker.image(fullImageTag).push()
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                def fullImageTag = "${DOCKER_REPOSITORY}:${BUILD_TAG}"
                echo "Cleaning up local Docker image: ${fullImageTag}"
                sh "docker rmi ${fullImageTag} || true"
            }
        }
        success {
            echo 'Build and push completed successfully!'
        }
        failure {
            echo 'Build or push failed. Check logs.'
        }
    }
}
