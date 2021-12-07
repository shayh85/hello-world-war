pipeline {
    agent any
    tools {
        maven "maven"
    }
    
    
    stages {
        stage('Build') { 
            steps {
                echo 'Building..'
                sh 'mvn -f pom.xml clean package' 
            }
        }
        stage('SonarCube-test') {
            steps {
                 sh '''export SONAR_TOKEN="eaad333aa9aafca011fb5a8eb97dbc99447ddb1b"
                 mvn verify org.sonarsource.scanner.maven:sonar-maven-plugin:sonar -Dsonar.projectKey=module6'''
            }
        }
            stage('docker build') {
                 steps {
        sh 'docker build -t hww-shalom:${BUILD_NUMBER} .'
      }
    }
      stage('docker tag') {
         steps {
        sh 'docker tag hww-shalom:${BUILD_NUMBER} localhost:8123/hww-shalom:${BUILD_NUMBER}'
      }
    }
        stage('docker push') {
             steps {
                script {
                  docker.withRegistry('http://localhost:8123', 'nexus') {
                      docker.build('module6-shayhelman').push('latest') }
        
      }
    }
}
      }
    
  environment {
    registry = 'http://localhost:8123'
    imageName = 'module6-shayhelman'
    registryCredentials = 'nexus'
    buildId = ''
  }
}