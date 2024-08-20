pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Kevine-fr/Studlearn.git'
            }
        }
        stage('Build and Deploy DataBase') {
            steps {
                script {
                    // Construisez les images Docker avant de démarrer les conteneurs
                    // bat 'docker-compose build'
                    
                    // Démarrez les conteneurs Docker
                    bat 'docker-compose up -d db phpmyadmin'
                }
            }
        }
        stage('Build and Install Dependencies') {
            steps {
                script {
                    // Assurez-vous que Composer est installé dans l'image Docker ou l'agent
                    bat 'composer install'
                    
                    // Utilisez la commande copy pour Windows
                    bat 'copy .env.example .env'
                    
                    // Exécutez les commandes Artisan
                    bat 'php artisan key:generate'
                    
                    bat 'powershell -Command "(Get-Content .env) -replace \'^DB_PASSWORD=.*\', \'DB_PASSWORD=password\' | Set-Content .env"'
                    bat 'powershell -Command "(Get-Content .env) -replace \'^DB_DATABASE=.*\', \'DB_DATABASE=studlearn\' | Set-Content .env"'
                    bat 'powershell -Command "((Get-Content .env) -replace \'^DB_HOST=.*\', \'DB_HOST=db\') | Set-Content .env"'

                    
                    bat 'php artisan migrate'
                }
            }
        }
        stage('Build and Deploy Application') {
            steps {
                script {
                    // Construisez les images Docker avant de démarrer les conteneurs
                    // bat 'docker-compose build'
                    
                    // Démarrez les conteneurs Docker
                    bat 'docker-compose up -d app'
                }
            }
        }
    }
}
