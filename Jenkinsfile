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
         stage('Terraform Plan') {
             when {
                expression { params.Action in ['Plan' , 'Apply' , 'Destroy'] && currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                script {
                    echo 'Executing terraform plan...'
                    sh 'terraform plan -out=plan.out'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.Action =='Apply' && currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                script {
                    input "Please approve to proceed Apply"
                    echo 'Executing terraform apply...'
                    sh 'terraform apply "plan.out"'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.Action =='Destroy' && currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                script {
                    input "Please approve to proceed Destroy"
                    echo 'Executing terraform destroy...'
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
}
