pipeline{  
    environment {
    registry = "juhityagi/spring-demo"
    }
  
  agent any
  stages {
        stage('Sonar') {
          
           steps {
                sh 'mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=maven \
                    -Dsonar.host.url=http://34.83.140.219:9000 \
                    -Dsonar.login=sqp_82459cd51654dd6e7a9de576636b1de8e6db780e \
                    -Dcheckstyle.skip'
                }
          }    
        stage('Build') {
          
           steps {
                
                   sh 'pwd'
                   sh 'sudo docker build .'
                }
          }
        stage('Publish') {
           environment {
               registryCredential = 'dockerhub'
           }
           steps{
              
              script {
                      docker.withRegistry( '', registryCredential ) {
                      def appimage = docker.build registry + ":$BUILD_NUMBER"
                      appimage.push()
                      
                  }
              }
           }
       }
        stage ('Deploy') {
           steps {
               script{
                 def image_id = registry + ":$BUILD_NUMBER"
                 sh "sed -i 's|image_id|$image_id|g' deployment.yml"
                 sh "kubectl apply -f deployment.yml -f service.yml"
                 sh "kubectl rollout status deployment hello-deployment"
                 sh "kubectl get service hello-svc"
                }
           }
       }
   }
}
