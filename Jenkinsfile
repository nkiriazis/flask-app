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

// pipeline {
//     agent any

//     environment {
//         IMAGE_NAME = "returnick/python-app"
//         // Use build number for unique tag, and also tag with 'latest'
//         IMAGE_TAG_BUILD = "${env.BUILD_NUMBER}"
//         IMAGE_TAG_LATEST = "latest"
//         // Optional: Add Git commit SHA for even better traceability
//         // GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse HEAD').trim() // This line also needs // if uncommented
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
//                         // Build and tag with the BUILD_NUMBER tag. The 'docker.build' step
//                         // returns an Image object that represents this specific image.
//                         dockerImage = docker.build("${IMAGE_NAME}:${IMAGE_TAG_BUILD}", ".")

//                         // Now, tag the *already built* dockerImage with the 'latest' tag.
//                         // You simply pass the full new tag string.
//                         dockerImage.tag(IMAGE_TAG_LATEST)                }
//             }
//         }
//         stage('Push to Docker Hub') {
//             steps {
//                 script {
//                     // Using docker.withRegistry for cleaner authentication
//                     docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
//                         dockerImage.push("${IMAGE_TAG_BUILD}")
//                         dockerImage.push("${IMAGE_TAG_LATEST}")
//                 }
//             }
//         }
//     }
// }

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
        // Όνομα του Docker Image σου (χωρίς το Docker Hub username)
        // Το Docker Hub username θα προστεθεί αυτόματα από το docker.withRegistry
        DOCKER_IMAGE_NAME = "python-app" // Προσαρμόστηκε για να ταιριάζει με το GitLab παράδειγμα (χωρίς returnick/)
        DOCKER_REPOSITORY = "returnick/${DOCKER_IMAGE_NAME}" // Αυτό θα είναι το πλήρες repo path στο Docker Hub

        // Μεταβλητές για build arguments
        BUILD_ENVIRONMENT = "staging" // Default value
        BUILD_API_VERSION = "${env.TAG_NAME ?: 'no-tag'}" // Χρησιμοποιεί το Git tag, αλλιώς 'no-tag'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nkiriazis/flask-app.git' // Βεβαιώσου ότι αυτό είναι το σωστό URL για το repo σου
            }
        }

        stage('Determine Build Arguments') {
            when { expression { return env.TAG_NAME != null } } // This stage only runs if triggered by a tag
            steps {
                script {
                    if (env.TAG_NAME =~ /-prod$/) { // Έλεγχος αν το tag τελειώνει σε -prod
                        echo "Git tag '${env.TAG_NAME}' detected. Setting build for PRODUCTION."
                        env.BUILD_ENVIRONMENT = "production"
                    } else {
                        echo "Git tag '${env.TAG_NAME}' detected. Setting build for STAGING."
                        env.BUILD_ENVIRONMENT = "staging"
                    }
                    env.BUILD_API_VERSION = env.TAG_NAME // API_VERSION είναι πάντα το Git tag
                    echo "Environment for build: ${env.BUILD_ENVIRONMENT}"
                    echo "API Version for build: ${env.BUILD_API_VERSION}"
                }
            }
        }

        stage('Build and Tag Docker Image') {
            steps {
                script {
                    // Πλήρες tag για το image (π.χ. returnick/python-app:v1.0.0-prod)
                    def fullImageTag = "${DOCKER_REPOSITORY}:${env.TAG_NAME}"

                    echo "Building Docker image: ${fullImageTag}"
                    docker.build(fullImageTag, """
                        --no-cache
                        --pull
                        --build-arg ENVIRONMENT=${env.BUILD_ENVIRONMENT}
                        --build-arg API_VERSION=${env.BUILD_API_VERSION}
                        .
                    """.stripIndent()) // Το stripIndent είναι για να αφαιρέσει τα κενά από το multi-line string

                    echo "Image built and tagged: ${fullImageTag}"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    def fullImageTag = "${DOCKER_REPOSITORY}:${env.TAG_NAME}"
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') { // Χρησιμοποιεί το Jenkins credential ID
                        echo "Pushing Docker image: ${fullImageTag}"
                        docker.image(fullImageTag).push() // Χρησιμοποιεί το image object για push
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
                // Διαγράφουμε το image τοπικά μετά το push
                def fullImageTag = "${DOCKER_REPOSITORY}:${env.TAG_NAME}"
                sh "docker rmi ${fullImageTag} || true" // '|| true' για να μην κολλήσει αν δεν υπάρχει
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