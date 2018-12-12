pipeline {
  agent any
  options {
    disableConcurrentBuilds()
    timeout(time: 10, unit: 'MINUTES')
  }
  tools {
    maven 'maven 3.6.0'
  }
  stages {
    stage('checking out submodules') {
      steps {
        sh 'git submodule init'
        sh 'git submodule update --init --recursive --remote'
      }
    }
    stage('Verify Tools') {
      steps {
        parallel (
          java: {
            sh 'java -version'
            sh 'which java'
          },
          maven: {
            sh 'mvn -version'
            sh 'which mvn'
          },
          docker: {
            sh 'docker --version'
            sh 'which docker'
          }
        )
      }
    }
    stage('Build') {
      steps {
          parallel (
            backend: {
              sh 'mvn package -DskipTests -f MovieDatabaseBackend/'
              archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true 
            },
            frontend : {
              sh 'pushd MovieFrontend && npm install && popd'
              sh 'pushd MovieFrontend && ng build && popd'
            }
          )
      }
    }
    /*
    stage('Test') {
      steps {
        parallel(
          backend : {
            sh 'mvn test -f MovieDatabaseBackend/'
          }
        //,frontend : {
        //  sh 'pushd MovieFrontend && ng e2e && popd'
          //}
        )
      }
      //post {
      //  always {
      //    junit '** /target/surefire-reports/*.xml'
      //  }
      //}
    }
    */
    stage('Deploy') {
       steps {
         sh 'chmod -R 777 .'
         sh 'docker build -t application .'
         sh 'docker rm -f application || true'
         sh 'docker run -d -p 80:80 --name application application'
         sh 'docker image prune -f'
       }
     }
  }
  post {
    always {
      cleanWs()
    }
  }
}