pipeline {
    agent any 
    
    tools{
        jdk 'jdk'
        maven 'maven'
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
                    -Dsonar.host.url=http://54.197.4.212:9000 \
                    -Dsonar.token=sqp_e89e90625ab5163e64fa01e6efb46bc41bdd1d79 '''
            }
        }
        stage("Build"){
            steps{
                sh "mvn clean install"
            }
        }
        
        stage('Docker Build') {
            steps {
               script{
                   withDockerRegistry(credentialsId: 'docker') {
                    sh "docker build -t  petclinic . "
                 }
               }
            }
        }

        stage('Docker Push') {
            steps {
               script{
                   withDockerRegistry(credentialsId: 'docker') {
                    sh "docker tag petclinic suvitha/pet-clinic:latest"
                    sh "docker push  suvitha/pet-clinic:latest"
                 }
               }
            }
        }
        
    }
}
