# Build stage
FROM gradle:jdk17 AS builder
WORKDIR /app
#Copy all files and directories from the current directory to /app
RUN gradle --no-daemon --version
COPY . .
RUN gradle build --no-daemon

# Final stage
FROM openjdk:17
COPY --from=builder /app/build/libs/*-SNAPSHOT.jar /app.jar
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "/app.jar"]

