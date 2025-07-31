// pipeline {
//     agent any

//     environment {
//         DOCKER_IMAGE_NAME = "flask-app"
//         DOCKER_REPOSITORY = "returnick/${DOCKER_IMAGE_NAME}"
//         BUILD_TAG = "${env.TAG_NAME ?: 'latest'}"
//     }

//     stages {
//         stage('Clean Workspace') {
//             steps {
//                 cleanWs()
//             }
//         }

//         stage('Checkout') {
//             steps {
//                 checkout([$class: 'GitSCM', 
//                     branches: [[name: 'refs/heads/main']], 
//                     userRemoteConfigs: [[
//                         url: 'https://github.com/nkiriazis/flask-app.git', 
//                         credentialsId: 'fb7cfa46-83f2-465b-b866-1627b1966877'
//                     ]]
//                 ])
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     def fullImageTag = "${DOCKER_REPOSITORY}:${BUILD_TAG}"
//                     echo "Building Docker image: ${fullImageTag}"
//                     docker.build(fullImageTag, "--pull .")
//                 }
//             }
//         }

//         stage('Push Docker Image') {
//             steps {
//                 script {
//                     def fullImageTag = "${DOCKER_REPOSITORY}:${BUILD_TAG}"
//                     docker.withRegistry('https://registry.hub.docker.com', '6970179e-8739-4f48-968d-fd404b31a95b') {
//                         echo "Pushing Docker image: ${fullImageTag}"
//                         docker.image(fullImageTag).push()
//                     }
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             script {
//                 def fullImageTag = "${DOCKER_REPOSITORY}:${BUILD_TAG}"
//                 echo "Cleaning up local Docker image: ${fullImageTag}"
//                 sh "docker rmi ${fullImageTag} || true"
//             }
//         }
//         success {
//             echo 'Build and push completed successfully!'
//         }
//         failure {
//             echo 'Build or push failed. Check logs.'
//         }
//     }
// }
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Κάνει checkout από το Git repo το branch main
                checkout([$class: 'GitSCM',
                          branches: [[name: 'refs/heads/main']],
                          userRemoteConfigs: [[url: 'https://github.com/nkiriazis/flask-app.git']]])
            }
        }

        stage('Build') {
            steps {
                // Παράδειγμα: εκτύπωση λίστας αρχείων
                sh 'ls -la'
                
                // Αν έχεις Python requirements:
                // sh 'pip install -r requirements.txt'
            }
        }
    }
}
