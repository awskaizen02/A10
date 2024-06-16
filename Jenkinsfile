pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
                git branch: 'war', url: 'https://github.com/awskaizen02/A10.git'
            }
        }
	stage('Build') {
            steps {
                sh 'mvn clean'
		sh 'mvn install'
            }
        }
	stage('Docker Image') {
            steps {
		script{
		 app = docker.build("dockerpandian/june16")
		  app.inside{
			  sh 'echo $(curl localhost:8080)'
					}
				}
     }
     }
stage('Push Docker Image') {
            steps {
		script{		
	docker.withRegistry('https://registry.hub.docker.com', 'dhub') {
	   app.push("${env.BUILD_NUMBER}")
	   app.push("latest")
					}
				}
			}
                            }
stage('Deploy to server') {
    steps {
	 input 'Deploy to Production?'
	 milestone(1)
	withCredentials([usernamePassword(credentialsId: 'ddeploy', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
			script{										
			  sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$dev_ip \"docker pull dockerpandian/june16:${env.BUILD_NUMBER}\""
	try{
sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$dev_ip \"docker stop demo-deploy\""
sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$dev_ip \"docker rm  demo-deploy\""
 }  catch (err) {
	echo: 'caught error: $err'
 }
 sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$dev_ip \"docker run --restart always --name demo-deploy -p 8080:8080 -d dockerpandian/june16:${env.BUILD_NUMBER}\""
				 }
				}
			}
				}                        
    }
}
