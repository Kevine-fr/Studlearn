pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    sh 'docker build -t studlearn-app .'
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    // Déployer les conteneurs avec Docker Compose
                    sh 'docker-compose down || true'
                    sh 'docker-compose up --build -d'
                }
            }
        }
    }
}
