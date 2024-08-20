pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Kevine-fr/Studlearn.git'
            }
        }
        stage('Build MySQL and phpMyAdmin') {
            steps {
                script {
                    // Build MySQL et phpMyAdmin
                    bat 'docker-compose up -d db phpmyadmin'
                }
            }
        }
        stage('Wait for MySQL') {
            steps {
                script {
                    // Attendre 5 secondes pour s'assurer que MySQL est prêt
                    bat 'timeout /t 5 /nobreak'
                }
            }
        }
        stage('Build and Deploy Application') {
            steps {
                script {
                    // Build l'application après que MySQL soit disponible
                    bat 'docker-compose up -d app'
                }
            }
        }
    }
}
