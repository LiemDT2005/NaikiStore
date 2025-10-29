# Stage 1: Build WAR từ source
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app

# Copy file cấu hình Maven và source code
COPY pom.xml .
COPY src ./src

# Build WAR
RUN mvn clean package

# Stage 2: Tomcat để chạy WAR
FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR từ stage 1
COPY --from=build /app/target/e-commerce-website-1.0.0.war /usr/local/tomcat/webapps/ROOT.war

# Expose cổng
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
