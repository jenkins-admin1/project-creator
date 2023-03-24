pipeline {
    agent any

    stages {
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
                dir('${provider}/${environment}/${region}') {
                    sh 'terragrunt init'
                }
            }
        }
        
        stage('validate') 
        {
            steps {
                dir('${provider}/${environment}/${region}') {
                    sh 'terragrunt plan'
                }
            }
        }
        
        stage('Terraform apply') 
        {
            steps {
                dir('${provider}/${environment}/${region}') {
                    echo "terragrunt action from the parameter is --> ${action}"
                sh ("terragrunt ${action} --auto-approve")
                }
            }
        }
    }
}
