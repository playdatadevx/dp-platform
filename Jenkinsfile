pipeline {
    agent any
    environment{
        CERT_ARN = credentials('CERT_ARN')
        AWS_DEFAULT_REGION = "ap-northeast-2"
        AWS_ACCESS_KEY_ID = credentials("access_key_id")
        AWS_SECRET_ACCESS_KEY = credentials("secret_access_key")
    }
    tools {
        terraform 'Terraform'
    }
    stages{
        stage('Git Checkout'){
            steps{
                git branch: 'main', credentialsId: 'git', url: 'https://github.com/playdatadevx/dp-platform'
                withCredentials([sshUserPrivateKey(credentialsId: 'gpg', keyFileVariable: 'gpg_secret', passphraseVariable: 'gpg_passphrase', usernameVariable: 'gpg'), file(credentialsId: 'gpg-trust', variable: 'gpg_trust')]) {
                sh 'gpg --batch --import $gpg_secret'
                sh 'gpg --import-ownertrust $gpg_trust'
                sh 'git secret reveal -p $gpg_passphrase'
                }
            }
        }
        stage('Terraform_backend Init'){
            steps{
                sh 'terraform -chdir=./terraform_backend init'                
            }
        }
        stage('Terraform_backend apply'){
            steps{
                sh 'terraform -chdir=./terraform_backend apply --auto-approve'                
            }
        }
        stage('Terraform Init'){
            steps{
                sh 'terraform -chdir=./terraform-for-cluster init'                
            }
        }
        stage('Terraform apply'){
            steps{
                sh 'terraform -chdir=./terraform-for-cluster apply --auto-approve'                
            }
        }
        stage('Context Connecting'){
            steps{
                sh 'aws eks update-kubeconfig --region ap-northeast-2 --name DevX --alias DevX'
            }
        }
        stage('Ansible Playbook'){
            steps{
                dir('./ansible_for_helm') {
                    sh "sudo sed -i 's|REPLACE-ARN|$CERT_ARN|g' *values.yaml"
                    sh 'ansible-galaxy collection install kubernetes.core'
                    sh 'ansible-playbook ECO-component-playbook.yaml'
                    
                }
            }
        }
    }
}