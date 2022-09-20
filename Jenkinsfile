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
  	                -Dsonar.host.url=http://34.168.229.153:9000 \
  	                -Dsonar.login=sqp_605a946e78e6cb3d55387b122cdde549e0edfe1a'
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
