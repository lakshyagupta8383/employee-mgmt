pipeline {
    agent none

    environment {
        IMAGE = "employee-app"
        REGISTRY = "guptalakshya"
        IMAGE_TAG = "${REGISTRY}/${IMAGE}:${env.BUILD_NUMBER}"
    }

    stages {
        stage('Clone') {
            agent { label 'master' } // or whichever node can access Git
            steps {
                git credentialsId: 'githubcreds', url: 'https://github.com/lakshyagupta8383/employee-mgmt.git'
            }
        }

        stage('Build') {
            agent {
                docker {
                    image 'maven:3.8.8-openjdk-17'
                    args '-v $HOME/.m2:/root/.m2' // cache dependencies
                }
            }
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'maven:3.8.8-openjdk-17'
                }
            }
            steps {
                sh 'mvn test'
                junit '**/target/surefire-reports/*.xml'
            }
        }

        stage('Docker Build & Push') {
            agent { label 'docker' } // or 'master' if Docker is on that node
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
            agent { label 'ansible' } // a node with Ansible installed
            steps {
                sh 'ansible-playbook -i ansible/hosts ansible/deploy.yml'
            }
        }
    }
}

