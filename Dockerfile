#
#
FROM openjdk:8u292-jre-slim

COPY *.jar /deployments/app.jar

EXPOSE 8080

# USER 1001

CMD ["java","-jar","/deployments/app.jar"]
