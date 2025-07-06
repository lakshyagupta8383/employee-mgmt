pipeline {
    agent any

    environment {
        IMAGE = "employee-app"
        REGISTRY = "guptalakshya" 
        IMAGE_TAG = "${REGISTRY}/${IMAGE}:${env.BUILD_NUMBER}"
    }

    stages {
        stage('Clone') {
    steps {
        git credentialsId: 'githubcreds', url: 'https://github.com/lakshyagupta8383/employee-mgmt.git'
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
                junit '**/target/surefire-reports/*.xml'
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
