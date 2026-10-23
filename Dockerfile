FROM maven:3.8-eclipse-temurin-8 AS build

WORKDIR /app

COPY pom.xml .
COPY host.json .
COPY src ./src

RUN mvn clean package -DskipTests

FROM mcr.microsoft.com/azure-functions/java:4-java8

ENV AzureWebJobsScriptRoot=/home/site/wwwroot

COPY --from=build /app/target/azure-functions/* /home/site/wwwroot
