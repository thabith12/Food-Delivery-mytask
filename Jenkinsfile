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

        stage('AWS ECR Push') {
    steps {
        withCredentials([usernamePassword(
            credentialsId: 'aws-ecr',
            usernameVariable: 'AWS_ACCESS_KEY_ID',
            passwordVariable: 'AWS_SECRET_ACCESS_KEY'
        )]) {
            sh '''
            aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 643603452212.dkr.ecr.eu-north-1.amazonaws.com

            docker tag thabith12/food-backend:v2 643603452212.dkr.ecr.eu-north-1.amazonaws.com/food-backend:v2
            docker tag thabith12/food-frontend:v2 643603452212.dkr.ecr.eu-north-1.amazonaws.com/food-frontend:v2

            docker push 643603452212.dkr.ecr.eu-north-1.amazonaws.com/food-backend:v2
            docker push 643603452212.dkr.ecr.eu-north-1.amazonaws.com/food-frontend:v2
            '''
        }
    }
}
stage('Remove Local Images') {
    steps {
        sh '''
        docker rmi thabith12/food-backend:v2 || true
        docker rmi thabith12/food-frontend:v2 || true
        '''
    }
}
stage('Deploy with Docker Compose') {
    steps {
        sh '''
        docker-compose pull
        docker-compose up -d
        '''
    }
}

stage('Verify Deployment') {
    steps {
        sh '''
        docker ps
        docker compose ps
        '''
    }
}

    }
}