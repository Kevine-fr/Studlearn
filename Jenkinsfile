pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Kevine-fr/Studlearn.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                bat 'docker build -t my-image .'
            }
        }
        stage('Pause for Docker Initialization') {
            steps {
                powershell 'Start-Sleep -Seconds 10'
            }
        }
        stage('Deploy with Docker Compose') {
            steps {
                bat 'docker-compose up -d'
            }
        }
    }
}
