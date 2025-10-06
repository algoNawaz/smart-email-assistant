# Stage 1: Build the application using a Maven image with JDK 21
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create the final, smaller runtime image using a Java 21 JRE
FROM eclipse-temurin:21-jre-focal
WORKDIR /app
COPY --from=build /app/target/email-writer-sb-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
