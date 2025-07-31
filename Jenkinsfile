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

// // Jenkinsfile (Improved Tagging)
// pipeline {
//     agent any

//     environment {
//         IMAGE_NAME = "returnick/python-app"
//         // Use build number for unique tag, and also tag with 'latest'
//         IMAGE_TAG_BUILD = "${env.BUILD_NUMBER}"
//         IMAGE_TAG_LATEST = "latest"
//         # Optional: Add Git commit SHA for even better traceability
//         # GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
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
//                     // Build and tag with both build number and latest
//                     dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG_BUILD}", ".")
//                     dockerImage.tag("${IMAGE_NAME}:${IMAGE_TAG_LATEST}")
//                 }
//             }
//         }

//         stage('Push to Docker Hub') {
//             steps {
//                 script {
//                     // Using docker.withRegistry for cleaner authentication
//                     docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
//                         dockerImage.push("${IMAGE_TAG_BUILD}")
//                         dockerImage.push("${IMAGE_TAG_LATEST}")
//                     }
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             echo 'Cleaning up Docker images on agent...'
//             // Clean up local images to save space, ignore errors if image doesn't exist
//             sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG_BUILD} || true"
//             sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG_LATEST} || true"
//         }
//     }
// }

pipeline {
    agent any

    environment {
        IMAGE_NAME = "returnick/python-app"
        // Use build number for unique tag, and also tag with 'latest'
        IMAGE_TAG_BUILD = "${env.BUILD_NUMBER}"
        IMAGE_TAG_LATEST = "latest"
        // Optional: Add Git commit SHA for even better traceability
        // GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse HEAD').trim() // This line also needs // if uncommented
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nkiriazis/python-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                        // Build and tag with the BUILD_NUMBER tag. The 'docker.build' step
                        // returns an Image object that represents this specific image.
                        dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG_BUILD}", ".")

                        // Now, tag the *already built* dockerImage with the 'latest' tag.
                        // You simply pass the full new tag string.
                        dockerImage.tag(IMAGE_TAG_LATEST)                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                script {
                    // Using docker.withRegistry for cleaner authentication
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                        dockerImage.push("${IMAGE_TAG_BUILD}")
                        dockerImage.push("${IMAGE_TAG_LATEST}")
                }
            }
        }
    }
}

    post {
        always {
            echo 'Cleaning up Docker images on agent...'
            // Clean up local images to save space, ignore errors if image doesn't exist
            sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG_BUILD} || true"
            sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG_LATEST} || true"
        }
    }
}