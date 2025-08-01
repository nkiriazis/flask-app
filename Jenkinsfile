// pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub')
        GITHUB_CREDENTIALS = credentials('github-pat')
        DOCKER_IMAGE = "returnick/flask-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/nkiriazis/flask-app.git', credentialsId: 'github-pat'
            }
        }

        stage('Set Version Tag') {
            steps {
                script {
                    def commitCount = sh(script: "git rev-list --count HEAD", returnStdout: true).trim()
                    env.DOCKER_TAG = "0.0.${commitCount}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push("latest")
                    }
                }
            }
        }
    }
}
