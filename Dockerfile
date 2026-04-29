# ── Stage 1: Build the WAR file ──────────────────────────────────────
FROM maven:3.9-eclipse-temurin-11 AS builder

WORKDIR /app
COPY pom.xml .
COPY src ./src

# Download dependencies & package the WAR
RUN mvn clean package -DskipTests

# ── Stage 2: Deploy on Tomcat ─────────────────────────────────────────
FROM tomcat:10.1-jdk11

# Remove default Tomcat apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy our WAR as ROOT so it's served at /  (not /bankapp/)
COPY --from=builder /app/target/bankapp.war /usr/local/tomcat/webapps/ROOT.war

# Expose the port Railway will forward to
EXPOSE 8080

CMD ["catalina.sh", "run"]
