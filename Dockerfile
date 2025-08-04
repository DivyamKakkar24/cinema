FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src 
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY target/cinema-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

CMD [ "java", "-jar", "app.jar" ]