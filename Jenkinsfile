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
                dir('${params.provider}/${params.environment}/${params.region}') {
                    echo "Provider: ${params.provider}"
                    echo "Environment: ${params.environment}"
                    echo "Region: ${params.region}"
                    sh 'terragrunt init'
                }
            }
        }
        
        stage('validate') 
        {
            steps {
                dir('${params.provider}/${params.environment}/${params.region}') {
                    sh 'terragrunt plan'
                }
            }
        }
        
        stage('Terraform apply') 
        {
            steps {
                dir('${params.provider}/${params.environment}/${params.region}') {
                    echo "terragrunt action from the parameter is --> ${action}"
                sh ("terragrunt ${action} --auto-approve")
                }
            }
        }
    }
}
