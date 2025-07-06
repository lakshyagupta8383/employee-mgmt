# Use Java 21 base image
FROM eclipse-temurin:21-jdk

# Set working directory
WORKDIR /app

# Copy the jar
COPY target/employee-mgmt-1.0.0.jar app.jar

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]

