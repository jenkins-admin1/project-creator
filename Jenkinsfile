pipeline {
    agent any

    stages 
    {
        stage('checkout') 
        {
            steps 
            {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/jenkins-admin1/project-creator.git']])
            }
        }
        
        stage('initialize') 
        {
            steps {
                sh "terragrunt init"
                }
        }
        
        stage('validate') 
        {
            steps {
                sh "terragrunt plan"
                }
        }
        
        stage('apply') 
        {
            steps {
                sh "terragrunt apply --auto-approve"
                }
        }
    }
}
