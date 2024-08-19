pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    bat 'docker build -t studlearn-app .'
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    // Déployer les conteneurs avec Docker Compose
                    bat 'docker-compose down || true'
                    bat 'docker-compose up --build -d'
                }
            }
        }
    }
}
