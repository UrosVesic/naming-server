# Stage 1: Build the application
FROM maven:3.6.3-openjdk-17 as build
COPY src /usr/home/naming-server/src
COPY ./pom.xml /usr/home/naming-server
RUN mvn -f /usr/home/naming-server/pom.xml clean package -DskipTests

# Stage 2: Package the application
FROM openjdk:17-jdk
COPY --from=build /usr/home/naming-server/target/*.jar /naming-server.jar
EXPOSE 8082
ENTRYPOINT ["java","-jar","/naming-server.jar"]