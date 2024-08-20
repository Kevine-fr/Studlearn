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
                    // Assurez-vous que Composer est installé dans l'image Docker ou l'agent
                    bat 'composer install'
                    bat 'cp .env.example .env'
                    bat 'php artisan key:generate'
                    bat 'php artisan migrate'

                    // Modifier le fichier .env pour configurer la base de données
                    // Utilisez une commande compatible avec l'environnement de l'agent
                    bat 'powershell -Command "(Get-Content .env) -replace ''^DB_PASSWORD=.*'', ''DB_PASSWORD=password'' | Set-Content .env"'
                    bat 'powershell -Command "(Get-Content .env) -replace ''^DB_DATABASE=.*'', ''DB_DATABASE=studlearn'' | Set-Content .env"'
                }
            }
        }
        stage('Build and Deploy Application') {
            steps {
                script {
                    // Construisez les images Docker avant de démarrer les conteneurs
                    // bat 'docker-compose build'
                    
                    // Démarrez les conteneurs Docker
                    bat 'docker-compose up -d'
                }
            }
        }
    }
}
