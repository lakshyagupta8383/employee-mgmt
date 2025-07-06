pipeline {
    agent any

    environment {
        IMAGE = "employee-app"
        REGISTRY = "guptalakshya"
        IMAGE_TAG = "${REGISTRY}/${IMAGE}:${BUILD_NUMBER}"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git credentialsId: 'githubcreds', url: 'https://github.com/lakshyagupta8383/employee-mgmt.git'
            }
        }

        stage('Build with Maven') {
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
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhubcredentialsid') {
                        sh "docker build -t ${IMAGE_TAG} ."
                        sh "docker push ${IMAGE_TAG}"
                    }
                }
            }
        }

        stage('Deploy via Ansible') {
            steps {
                sh 'ansible-playbook -i ansible/hosts ansible/deploy.yml'
            }
        }
    }

    post {
        failure {
            echo "❌ Build failed!"
        }
        success {
            echo "✅ Build and deployment succeeded!"
        }
    }
}

