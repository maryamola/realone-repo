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
        
         stage('push to Nexus') {
          steps {
              nexusArtifactUploader artifacts: [[artifactId: 'SampleWebApp', classifier: '', file: 'SampleWebApp/target/SampleWebApp.war', type: 'war']], credentialsId: 'nexus', groupId: 'SampleWebApp', nexusUrl: '44.202.23.11:8081', nexusVersion: 'nexus3', protocol: 'http', repository: 'maven-snapshots', version: '1.0-SNAPSHOT'
              } 
        
         }
        stage('Deploy to tomcat') {
           steps {
               deploy adapters: [tomcat9(credentialsId: '6dfdddd7-494f-4ed1-8f8a-5a65b3841bdf', path: '', url: 'http://34.226.155.98:8080')], contextPath: 'myapp', war: '**/*.war'
               }
        }
    }
}
