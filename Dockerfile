FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn package

FROM openjdk:11-jdk-slim AS run
WORKDIR /app

COPY --from=build /app/target/my-app-*.jar /app/my-app.jar

CMD ["sh", "-c", "java -jar /app/my-app.jar; sleep 100"]
