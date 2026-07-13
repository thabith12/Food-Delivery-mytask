pipeline {
    agent any

    stages {

        stage('Test Connection') {
            steps {
                echo 'Jenkins connected successfully'
            }
        }

        stage('Docker Build Backend') {
            steps {
                sh '''
                docker build -t thabith12/food-backend:v2 ./backend
                '''
            }
        }

        stage('Docker Build Frontend') {
            steps {
                sh '''
                docker build -t thabith12/food-frontend:v2 ./frontend
                '''
            }
        }

    }
}