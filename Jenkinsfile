
pipeline {
   agent any
    
   // set path
   stages {
      stage ('set terraform path'){
          steps{
              script{
                  def tfHome = tool name: 'terraform'
                  env.PATH = "${tfHome}:${env.PATH}"
              }
            sh 'terraform --version'
            sh 'terraform init'
          }
      }

      //delete
      stage('terraform delete') {
        steps {
          withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'awsCredentials',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
          ]]) {
            ansiColor('xterm') {
              sh 'terraform destroy --force'
            }
          }
        }
      }

      //clean
      stage('Cleaning build') {
        steps {
            sh 'rm -f terraform.tfstate'
        }
      }



      //init
      stage('terraform init') {
        steps {
          withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'awsCredentials',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
          ]]) {
            ansiColor('xterm') {
              sh 'terraform init'
            }
          }
        }
      }

      //plan
      stage('terraform plan') {
        steps {
          withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'awsCredentials',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
          ]]) {
            ansiColor('xterm') {
              sh 'terraform plan'
            }
          }
        }
      }


      //apply
      stage('terraform apply') {
        steps {
          withCredentials([[
            $class: 'AmazonWebServicesCredentialsBinding',
            credentialsId: 'awsCredentials',
            accessKeyVariable: 'AWS_ACCESS_KEY_ID',
            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
          ]]) {
            ansiColor('xterm') {
              sh 'terraform apply -auto-approve'
            }
          }
        }
      }

      

   }
}
