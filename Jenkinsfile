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
               deploy adapters: [tomcat9(credentialsId: '44d0c8f7-c308-43c1-b5cb-5470623a779a', path: '', url: 'http://3.92.184.198:8080/')], contextPath: 'myapp', war: '**/*.war'
               }
        }
    }
}
