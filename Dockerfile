FROM openjdk:8-jre-alpine
COPY $WORKSPACE/capstone/target/*.jar /usr/app/*.jar
ENTRYPOINT ["java","-jar","/usr/app/*.jar"]
