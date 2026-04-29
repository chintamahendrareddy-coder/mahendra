# Stage 1: Build the WAR file
FROM maven:3.9-eclipse-temurin-11 AS builder

WORKDIR /app

COPY pom.xml .

RUN mkdir -p src/main/webapp/WEB-INF

COPY *.jsp src/main/webapp/

RUN echo '<?xml version="1.0" encoding="UTF-8"?><web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd" version="4.0"><display-name>Bank Admin App</display-name><welcome-file-list><welcome-file>index.jsp</welcome-file></welcome-file-list><session-config><session-timeout>30</session-timeout></session-config></web-app>' > src/main/webapp/WEB-INF/web.xml

RUN mvn clean package -DskipTests

# Stage 2: Deploy on Tomcat
FROM tomcat:10.1-jdk11

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/target/bankapp.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
