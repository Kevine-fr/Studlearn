pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Kevine-fr/Studlearn.git'
            }
        }
        stage('Build and Deploy with Docker Compose') {
            steps {
                script {
                    // Construire les images et démarrer les services
                    bat 'docker-compose build'
                    bat 'docker-compose up -d'
                }
            }
        }
    }
}
