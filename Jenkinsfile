pipeline {
    agent any

    

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
