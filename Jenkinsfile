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
                    passwordVariable: 'dckr_pat_4uoyFA3Dkwfr_UuXCWCHjQzgiCE'
                )]) {
                    sh '''
                    echo "dckr_pat_4uoyFA3Dkwfr_UuXCWCHjQzgiCE" | docker login -u "thabith12" --password-stdin

                    docker push thabith12/food-backend:v2
                    docker push thabith12/food-frontend:v2

                    docker logout
                    '''
                }
            }
        }

    }
}