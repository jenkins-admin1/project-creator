pipeline {
    agent any

    stages 
    {
        stage('checkout') 
        {
            steps 
            {
                checkout scmGit(
                    branches: [[name: '*/master']], 
                    extensions: [
                        [
                            $class: 'SubmoduleOption', 
                            disableSubmodules: false, 
                            parentCredentials: true, 
                            recursiveSubmodules: true, 
                            reference: '', 
                            trackingSubmodules: false
                        ]
                    ],
                    userRemoteConfigs: [[url: 'https://github.com/jenkins-admin1/project-creator.git']]
                )

            }
        }
        
        stage('initialize') 
        {
            steps {
                sh "cd /var/lib/jenkins/workspace/project-creator/${params.provider}/${params.environment}/${params.region} && terragrunt init"
                }
        }
        
        stage('validate') 
        {
            steps {
                sh "cd /var/lib/jenkins/workspace/project-creator/${params.provider}/${params.environment}/${params.region} && terragrunt plan"
                }
        }
        
        stage('apply') 
        {
            steps {
                sh "cd /var/lib/jenkins/workspace/project-creator/${params.provider}/${params.environment}/${params.region} && terragrunt apply --auto-approve"
                }
        }
    }
}
