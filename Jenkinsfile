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

        stage('Docker Hub Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'thabith12',
                    passwordVariable: 'thabith4136#'
                )]) {
                    sh '''
                    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

                    docker push thabith12/food-backend:v2
                    docker push thabith12/food-frontend:v2

                    docker logout
                    '''
                }
            }
        }

    }
}