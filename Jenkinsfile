pipeline {
    agent any 
    
    tools{
        jdk 'jdk11'
        maven 'maven3'
    }
    
    environment {
        SCANNER_HOME=tool 'sonar-scanner'
    }
    
    stages{
        
        stage("Git Checkout"){
            steps{
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/jaiswaladi246/Petclinic.git'
            }
        }
        
        stage("Compile"){
            steps{
                sh "mvn clean compile"
            }
        }
        
         stage("Test Cases"){
            steps{
                sh "mvn test"
            }
        }
        
        stage("Sonarqube Analysis "){
            steps{
                    sh " mvn clean package "
                    sh ''' mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=Petclinic \
                    -Dsonar.projectName='Petclinic' \
                    -Dsonar.host.url=http://54.160.215.169:9000 \
                    -Dsonar.token=sqp_f42af8c38cd107f5fa9d877adce5a7d8fef240c2 '''
            }
        }
        stage("Build"){
            steps{
                sh "mvn clean install"
            }
        }
    }
}
