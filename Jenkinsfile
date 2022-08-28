pipeline {
    agent any

    stages {
        stage('Git checkout') {
            steps {
                git 'https://github.com/maryamola/realone-repo.git'
            }
        }
        
        stage('Build with maven') {
            steps {
                sh 'cd SampleWebApp && mvn clean install'
            }
        }
        
             stage('Test') {
            steps {
                sh 'cd SampleWebApp && mvn test'
            }
        
            }
        stage('Code Qualty Scan') {

           steps {
                  withSonarQubeEnv('sonarserver') {
             sh "mvn -f SampleWebApp/pom.xml sonar:sonar"      
               }
            }
       }
        stage('Quality Gate') {
          steps {
                 waitForQualityGate abortPipeline: true
              }
        }
        stage('Deploy to tomcat') {
           steps {
               deploy adapters: [tomcat9(credentialsId: '6dfdddd7-494f-4ed1-8f8a-5a65b3841bdf', path: '', url: 'http://34.226.155.98:8080')], contextPath: 'myapp', war: '**/*.war'
               }
        }
    }
}
