pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Clonar el repositorio
                checkout scm
            }
        }

        stage('Login to GitLab Container Registry') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'id-de-credenciales-del-registry', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        
                        echo "El nombre de usuario es: ${USERNAME}"
                        echo "La contraseña es: ${PASSWORD}"
                        sh "docker login -u ${USERNAME} -p ${PASSWORD} registry.gitlab.com"
                        sh "docker build -t mi-imagen-nodejs:alpine3.18 ."
                        sh "docker push mi-imagen-nodejs:alpine3.18"
                    }

                    // Utiliza las credenciales para realizar el inicio de sesión en GitLab Container Registry
                    //sh "echo ${gitlabCredentials.username} "
                    //sh "docker login -u ${gitlabCredentials.username} -p ${gitlabCredentials.password} registry.gitlab.com"
                    //sh "docker build -t mi-imagen-nodejs:alpine3.18 ."
                    //sh "docker push mi-imagen-nodejs:alpine3.18"
                }
            }
        }

        /*stage('Build and Push Docker Image') {
            environment {
                // Define las variables de configuración del registro Docker local
                DOCKER_REGISTRY_URL = 'https://registry.gitlab.com' // Cambia por la URL de tu registro local
                DOCKER_REGISTRY_CREDENTIALS_ID = 'id-de-credenciales-del-registry' // Cambia por el ID de tus credenciales
                DOCKER_IMAGE_NAME = 'nombre-de-imagen' // Cambia por el nombre deseado para tu imagen
                DOCKERFILE_PATH = '.' // Directorio actual
                NODEJS_VERSION = 'alpine3.18'
            }

            steps {
                // Construir la imagen Docker
                script {
                    //def dockerImage = docker.build("${DOCKER_REGISTRY_URL}/${DOCKER_IMAGE_NAME}:${NODEJS_VERSION}", "--build-arg NODEJS_VERSION=${NODEJS_VERSION} ${DOCKERFILE_PATH}")
                    def dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${NODEJS_VERSION}", "--build-arg NODEJS_VERSION=${NODEJS_VERSION} ${DOCKERFILE_PATH}")
                }

                // Iniciar sesión en el registro Docker local
                script {
                    //withCredentials([string(credentialsId: "${DOCKER_REGISTRY_CREDENTIALS_ID}", variable: 'DOCKER_REGISTRY_CREDENTIALS')]) {
                        docker.withRegistry("${DOCKER_REGISTRY_URL}", "${DOCKER_REGISTRY_CREDENTIALS_ID}") {
                            // Empujar la imagen al registro Docker local
                            dockerImage.push()
                        }
                    //}
                }
            }
        }*/
    }

    post {
        success {
            // Notificar el éxito de la construcción
            echo 'La construcción y el empuje de la imagen Docker se han realizado con éxito.'
        }
        failure {
            // Notificar si la construcción falla
            echo 'La construcción y el empuje de la imagen Docker han fallado.'
        }
    }
}

