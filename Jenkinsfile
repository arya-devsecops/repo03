parameters([choice(name: 'Action' , choices: ['Plan' , 'Apply' , 'Destroy'] , description: 'Please select the action')])
pipeline {
    agent any
options {
  ansiColor('xterm')
    }
    environment {
        ARM_CLIENT_ID         = credentials('CLIENT_ID')
        ARM_CLIENT_SECRET     = credentials('CLIENT_SECRET')
        ARM_SUBSCRIPTION_ID   = credentials('SUBSCRIPTION_ID')
        ARM_TENANT_ID         = credentials('TENANT_ID')
        }
    stages {
        stage('Git Checkout') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'repo', url: 'https://github.com/Arya5596/repo03']])
                
            }
        }
          stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform code format check') {
            steps{
                script {
                    sh 'terraform fmt'
                }
            }
        } 
        stage('Terraform validate') {
            steps {
                script {
                    sh 'terraform validate'
                }
            }
        }
                    switch (params.Action) {
                        
                        case 'Plan':
                        stage('Terraform plan'){
                            sh 'terraform plan -out=plan.out'
                        }
                        break
                        
                        case 'Apply':
                        when {
        expression {
            // Only apply if the plan was successful
            return currentBuild.resultIsBetterOrEqualTo('SUCCESS')
        }
                        }
                        stage('Terraform Apply') {
                             // terraform plan output saved in plan.output file
                            sh 'terraform plan -out=plan.out'
                            timeout(time: 1, unit: 'MINUTES'){
                                input "Do you want to proceed"
                            }
                             sh 'terraform apply "plan.out"'
                        }
                        break
                        
                        case 'Destroy':
                        stage('Terraform Destroy'){
                            sh 'terraform plan'
                            timeout(time: 1, unit: 'MINUTES'){
                                input "Do you want to destroy all resources"
                            }
                            // to destroy the all resource
                            sh 'terraform destroy --auto-approve'
                        }
                        break
                    }
                }
            }
        }
    }
}
                
