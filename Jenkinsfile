pipeline {
    agent any

    environment {
        DOCKER_IMAGE_BACKEND = "thabith12/food-backend:v2"
        DOCKER_IMAGE_FRONTEND = "thabith12/food-frontend:v2"
    }

    stages {

        stage('Clone Repository') {
            steps {
                git branch: 'main',
                url: https://github.com/thabith12/Food-Delivery-mytask
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                docker build -t $DOCKER_IMAGE_BACKEND ./backend
                docker build -t $DOCKER_IMAGE_FRONTEND ./frontend
                '''
            }
        }

    }
}