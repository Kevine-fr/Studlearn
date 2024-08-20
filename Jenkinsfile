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
                    // Construisez les images Docker avant de dÃ©marrer les conteneurs
                    // bat 'docker-compose build'
                    
                    // DÃ©marrez les conteneurs Docker
                    bat 'docker-compose up -d db phpmyadmin'
                }
            }
        }
        stage('Build and Install Dependencies') {
            steps {
                script {
                    // Assurez-vous que Composer est installÃ© dans l'image Docker ou l'agent
                    bat 'composer install'
                    
                    // Utilisez la commande copy pour Windows
                    bat 'copy .env.example .env'
                    
                    // ExÃ©cutez les commandes Artisan
                    bat 'php artisan key:generate'
                    
                    bat 'powershell -Command "(Get-Content .env) -replace \'^DB_PASSWORD=.*\', \'DB_PASSWORD=password\' | Set-Content .env"'
                    bat 'powershell -Command "(Get-Content .env) -replace \'^DB_DATABASE=.*\', \'DB_DATABASE=studlearn\' | Set-Content .env"'
                    
                    bat 'php artisan migrate --force'
                }
            }
        }
        stage('Build and Deploy Application') {
            steps {
                script {
                    // Construisez les images Docker avant de dÃ©marrer les conteneurs
                    // bat 'docker-compose build'
                    
                    // DÃ©marrez les conteneurs Docker
                    bat 'docker-compose up -d app'
                }
            }
        }
    }
}
