#
#
FROM redhat-openjdk-18/openjdk18-openshift:1.8

COPY /target/*.jar /deployments/app.jar

EXPOSE 8080

# USER 1001

CMD ["java","-jar","/deployments/app.jar"]
