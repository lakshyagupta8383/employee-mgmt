pipeline {
    agent any

    environment {
        IMAGE = "employee-app"
        REGISTRY = "guptalakshya"  // Set your Docker registry username here 
        IMAGE_TAG = "${REGISTRY}/${IMAGE}:${env.BUILD_NUMBER}"
    }

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/lakshyagupta8383/employee-mgmt.git' 
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
                junit '**/target/surefire-reports/*.xml' // Publish JUnit test reports
            }
        }
        stage('Docker Build & Push') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhubcredentialsid') {
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
}
