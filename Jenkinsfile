pipeline {

    agent any

    environment {
        BACKEND_IMAGE = "thabith12/food-backend"
        FRONTEND_IMAGE = "thabith12/food-frontend"

        VERSION = "v6"
    }


    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'feature/thabith12',
                url: 'https://github.com/thabith12/Food-Delivery-mytask.git'
            }
        }


        stage('Docker Build Backend') {
            steps {
                sh '''
                docker build -t $BACKEND_IMAGE:$VERSION ./backend
                '''
            }
        }


        stage('Docker Build Frontend') {
            steps {
                sh '''
                docker build -t $FRONTEND_IMAGE:$VERSION ./frontend
                '''
            }
        }


        stage('Docker Hub Login') {
            steps {

                withCredentials([
                    usernamePassword(
                    credentialsId: 'dockerhub',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                    )
                ]) {

                    sh '''
                    echo $DOCKER_PASS | docker login \
                    -u $DOCKER_USER \
                    --password-stdin
                    '''

                }

            }
        }


        stage('Push Images') {

            steps {

                sh '''

                docker push $BACKEND_IMAGE:$VERSION

                docker push $FRONTEND_IMAGE:$VERSION

                '''

            }

        }


        stage('Verify Images') {

            steps {

                sh '''

                docker images | grep food

                '''

            }

        }


    }


    post {

        success {

            echo "Docker images pushed successfully. ArgoCD Image Updater will update Kubernetes."

        }


        failure {

            echo "Pipeline failed"

        }

    }

}
