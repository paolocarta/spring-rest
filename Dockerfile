#
#
FROM openjdk:8u292-jre-slim

COPY ./shift-rest-1.0.0-SNAPSHOT.jar ./app.jar

EXPOSE 8080

# USER 1001

CMD ["java","-jar","./app.jar"]
