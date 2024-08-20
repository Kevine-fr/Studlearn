pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Kevine-fr/Studlearn.git'
            }
        }
        stage('Build and Install Dependencies') {
            steps {
                script {
                    // Assurez-vous que composer est installé et utilisez-le pour installer les dépendances
                    bat 'composer install'
                    bat 'cp .env.example .env'
                    bat 'php artisan key:generate'
                    bat 'php artisan migrate'
                }
            }
        }
        stage('Build and Deploy Application') {
            steps {
                script {
                    // Démarrez les conteneurs Docker
                    bat 'docker-compose up -d'
                }
            }
        }
    }
}
