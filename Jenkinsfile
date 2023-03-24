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
                    sh 'terraform init'
                }
            }
        }
        
        stage('validate') 
        {
            steps {
                dir('${provider}/${environment}/${region}') {
                    sh 'terraform plan'
                }
            }
        }
        
        stage('Terraform apply') 
        {
            steps {
                dir('${provider}/${environment}/${region}') {
                    echo "terraform action from the parameter is --> ${action}"
                sh ("terraform ${action} --auto-approve")
                }
            }
        }
    }
}
