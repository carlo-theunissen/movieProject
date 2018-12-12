pipeline {
  agent any
  options {
    disableConcurrentBuilds()
    timeout(time: 10, unit: 'MINUTES')
  }
  stages {
    stage('checking out submodules') {
      steps {
        sh 'git submodule init'
        sh 'git submodule update'
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
            }
            frontend : {
              sh 'pushd MovieFrontend && npm install && popd'
              sh 'pushd MovieFrontend && ng build && popd'
            }
          )
      }
    }
    stage('Test') {
      steps {
        parallel(
          backend : {
            sh 'mvn test -f MovieDatabaseBackend/'
          }
          frontend : {
            sh 'pushd MovieFrontend && ng e2e && popd'
          }
        )
      }
      //post {
      //  always {
      //    junit '**/target/surefire-reports/*.xml'
      //  }
      //}
    }
    stage('Deploy') {
       steps {
         sh 'docker build -t isaak-backend .'
         sh 'docker rm -f isaak-backend || true'
         sh 'docker run -d -p 8090:8090 --name isaak-backend isaak-backend'
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