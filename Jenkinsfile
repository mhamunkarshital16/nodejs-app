pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/mhamunkarshital16/nodejs-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t node-js:v1 .'
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker tag node-js:v1 username/your-image'
                sh 'docker push username/your-image'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
