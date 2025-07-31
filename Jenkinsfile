// // pipeline {
// //     agent any

// //     environment {
// //         IMAGE_NAME = "returnick/python-app"
// //         IMAGE_TAG = "latest"
// //     }

// //     stages {
// //         stage('Checkout') {
// //             steps {
// //                 git branch: 'main', url: 'https://github.com/nkiriazis/python-app.git'
// //             }
// //         }

// //         stage('Build Docker Image') {
// //             steps {
// //                 script {
// //                     dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
// //                 }
// //             }
// //         }

// //         stage('Push to Docker Hub') {
// //             steps {
// //                 withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
// //                     script {
// //                         sh '''
// //                             echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
// //                             docker push ${IMAGE_NAME}:${IMAGE_TAG}
// //                         '''
// //                     }
// //                 }
// //             }
// //         }
// //     }

// //     post {
// //         always {
// //             echo 'Cleaning up Docker credentials...'
// //             sh 'docker logout || true'
// //         }
// //     }
// // }

// // // Jenkinsfile (Improved Tagging)
// // pipeline {
// //     agent any

// //     environment {
// //         IMAGE_NAME = "returnick/python-app"
// //         // Use build number for unique tag, and also tag with 'latest'
// //         IMAGE_TAG_BUILD = "${env.BUILD_NUMBER}"
// //         IMAGE_TAG_LATEST = "latest"
// //         # Optional: Add Git commit SHA for even better traceability
// //         # GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
// //     }

// //     stages {
// //         stage('Checkout') {
// //             steps {
// //                 git branch: 'main', url: 'https://github.com/nkiriazis/python-app.git'
// //             }
// //         }

// //         stage('Build Docker Image') {
// //             steps {
// //                 script {
// //                     // Build and tag with both build number and latest
// //                     dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG_BUILD}", ".")
// //                     dockerImage.tag("${IMAGE_NAME}:${IMAGE_TAG_LATEST}")
// //                 }
// //             }
// //         }

// //         stage('Push to Docker Hub') {
// //             steps {
// //                 script {
// //                     // Using docker.withRegistry for cleaner authentication
// //                     docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
// //                         dockerImage.push("${IMAGE_TAG_BUILD}")
// //                         dockerImage.push("${IMAGE_TAG_LATEST}")
// //                     }
// //                 }
// //             }
// //         }
// //     }

// //     post {
// //         always {
// //             echo 'Cleaning up Docker images on agent...'
// //             // Clean up local images to save space, ignore errors if image doesn't exist
// //             sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG_BUILD} || true"
// //             sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG_LATEST} || true"
// //         }
// //     }
// // }

// // pipeline {
// //     agent any

// //     environment {
// //         IMAGE_NAME = "returnick/python-app"
// //         // Use build number for unique tag, and also tag with 'latest'
// //         IMAGE_TAG_BUILD = "${env.BUILD_NUMBER}"
// //         IMAGE_TAG_LATEST = "latest"
// //         // Optional: Add Git commit SHA for even better traceability
// //         // GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse HEAD').trim() // This line also needs // if uncommented
// //     }

// //     stages {
// //         stage('Checkout') {
// //             steps {
// //                 git branch: 'main', url: 'https://github.com/nkiriazis/python-app.git'
// //             }
// //         }

// //         stage('Build Docker Image') {
// //             steps {
// //                 script {
// //                         // Build and tag with the BUILD_NUMBER tag. The 'docker.build' step
// //                         // returns an Image object that represents this specific image.
// //                         dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG_BUILD}", ".")

// //                         // Now, tag the *already built* dockerImage with the 'latest' tag.
// //                         // You simply pass the full new tag string.
// //                         dockerImage.tag(IMAGE_TAG_LATEST)                }
// //             }
// //         }
// //         stage('Push to Docker Hub') {
// //             steps {
// //                 script {
// //                     // Using docker.withRegistry for cleaner authentication
// //                     docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
// //                         dockerImage.push("${IMAGE_TAG_BUILD}")
// //                         dockerImage.push("${IMAGE_TAG_LATEST}")
// //                 }
// //             }
// //         }
// //     }
// // }

// //     post {
// //         always {
// //             echo 'Cleaning up Docker images on agent...'
// //             // Clean up local images to save space, ignore errors if image doesn't exist
// //             sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG_BUILD} || true"
// //             sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG_LATEST} || true"
// //         }
// //     }
// // }

// pipeline {
//     agent any

//     environment {
//         IMAGE_NAME = "returnick/python-app"
//         IMAGE_TAG = "latest"
//     }

//     stages {
//         stage('Checkout') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/nkiriazis/python-app.git'
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
//                 }
//             }
//         }

//         stage('Push to Docker Hub') {
//             steps {
//                 withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
//                     script {
//                         sh '''
//                             echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
//                             docker push ${IMAGE_NAME}:${IMAGE_TAG}
//                         '''
//                     }
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             echo 'Cleaning up Docker credentials...'
//             sh 'docker logout || true'
//         }
//     }
// }

pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "flask-app"
        DOCKER_REPOSITORY = "returnick/${DOCKER_IMAGE_NAME}"
        BUILD_ENVIRONMENT = "staging"
        BUILD_API_VERSION = "${env.TAG_NAME ?: 'no-tag'}"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: '6970179e-8739-4f48-968d-fd404b31a95b',
                    branch: 'main',
                    url: 'https://github.com/nkiriazis/flask-app.git'
            }
        }

        stage('Determine Build Arguments') {
            when { expression { return env.TAG_NAME != null } }
            steps {
                script {
                    if (env.TAG_NAME =~ /-prod$/) {
                        echo "Git tag '${env.TAG_NAME}' detected. Setting build for PRODUCTION."
                        env.BUILD_ENVIRONMENT = "production"
                    } else {
                        echo "Git tag '${env.TAG_NAME}' detected. Setting build for STAGING."
                        env.BUILD_ENVIRONMENT = "staging"
                    }
                    env.BUILD_API_VERSION = env.TAG_NAME
                    echo "Environment for build: ${env.BUILD_ENVIRONMENT}"
                    echo "API Version for build: ${env.BUILD_API_VERSION}"
                }
            }
        }

        stage('Build and Tag Docker Image') {
            steps {
                script {
                    if (!fileExists('Dockerfile')) {
                        error 'Dockerfile not found in repository root!'
                    }

                    def fullImageTag = "${DOCKER_REPOSITORY}:${env.TAG_NAME ?: 'latest'}"

                    echo "Building Docker image: ${fullImageTag}"
                    docker.build(fullImageTag, """
                        --no-cache
                        --pull
                        --build-arg ENVIRONMENT=${env.BUILD_ENVIRONMENT}
                        --build-arg API_VERSION=${env.BUILD_API_VERSION}
                        .
                    """.stripIndent())

                    echo "Image built and tagged: ${fullImageTag}"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    def fullImageTag = "${DOCKER_REPOSITORY}:${env.TAG_NAME ?: 'latest'}"
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                        echo "Pushing Docker image: ${fullImageTag}"
                        docker.image(fullImageTag).push()
                    }
                    echo "Image pushed successfully."
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker images on agent...'
            script {
                def fullImageTag = "${DOCKER_REPOSITORY}:${env.TAG_NAME ?: 'latest'}"
                sh "docker rmi ${fullImageTag} || true"
                echo "Local Docker image ${fullImageTag} removed."
            }
        }
        failure {
            echo 'Pipeline failed. Check logs for details.'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
    }
}
