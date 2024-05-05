pipeline {
    agent any
 parameters { 
    choice(name: 'BRANCH_TO_BUILD', choices: ['war', 'jar'], description: '') 
	string(name: 'MAVEN_GOAL', defaultValue: 'mvn install', description: 'maven build')
}
triggers { pollSCM('* * * * *') }

    stages {
        stage('SCM') {
            steps {
                git branch: "${params.BRANCH_TO_BUILD}", url: 'https://github.com/awskaizen02/A10.git'
            }
        }
        stage('build') {
            steps {
                bat "${params.MAVEN_GOAL}"
            }
        }
        stage('deploy') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'webserver1', path: '', url: 'http://localhost:9091/')], contextPath: 'demo-pipeline', war: '**/*.war'
            }
        }
    }
}
