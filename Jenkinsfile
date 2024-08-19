pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/Kevine-fr/Studlearn.git'
        MYSQL_ROOT_PASSWORD = 'password'
        MYSQL_DATABASE = 'studlearn'
        MYSQL_USER = 'root'
        MYSQL_PASSWORD = 'password'
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the Git repository
                git branch: 'main', url: "${GIT_REPO}"
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    // Build the Laravel application Docker image
                    bat 'docker-compose build'
                }
            }
        }

        stage('Deploy Services') {
            steps {
                script {
                    // Start the Docker Compose services
                    bat 'docker-compose up -d'
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    // Wait for a few seconds to ensure services are up
                    bat 'sleep 10'

                    // Check the status of the Docker containers
                    bat 'docker-compose ps'
                }
            }
        }
    }

    post {
        always {
            // Clean up any unused Docker resources after the pipeline completes
            bat 'docker system prune -f'
        }

        success {
            echo 'Deployment succeeded!'
        }

        failure {
            echo 'Deployment failed!'
        }
    }
}
