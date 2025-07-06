pipeline {
    agent any

    environment {
        IMAGE_NAME = "employee-mgmt"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'githubcreds', url: 'https://github.com/lakshyagupta8383/employee-mgmt.git', branch: 'master'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhubcredentialsid',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    script {
                        def image = "${DOCKER_USER}/${IMAGE_NAME}:latest"
                        sh """
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker build -t $image .
                            docker push $image
                            docker logout
                        """
                    }
                }
            }
        }

        stage('Deploy via Ansible') {
            when {
                expression { return false } // Change to true to enable
            }
            steps {
                echo 'Deploying using Ansible...'
                // sh 'ansible-playbook deploy.yml'
            }
        }
    }

    post {
        failure {
            echo "❌ Build failed!"
        }
        success {
            echo "✅ Build succeeded!"
        }
    }
}

