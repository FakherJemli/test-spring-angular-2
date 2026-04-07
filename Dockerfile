# Generated Dockerfile — Spring Boot (Maven / Java 17)
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /workspace
COPY pom.xml .
COPY src ./src
RUN mvn -B -DskipTests package
RUN test -n "$(ls /workspace/target/*.jar 2>/dev/null)" || (echo "ERROR: no JAR found at /workspace/target/*.jar" && exit 1)

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /workspace/target/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
