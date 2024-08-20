pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Kevine-fr/Studlearn.git'
            }
        }
        stage('Build and Deploy Application') {
            steps {
                script {
                    // Build l'application après que MySQL soit disponible
                    bat 'docker-compose up'
                }
            }
        }
    }
}
