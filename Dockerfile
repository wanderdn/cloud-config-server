FROM gradle:7.6.0-jdk17-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM openjdk:17.0.2

EXPOSE 8081

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/config-server.jar /app/app.jar

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]