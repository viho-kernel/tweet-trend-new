FROM openjdk:21
ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar ttrend.jar
ENTRYPOINT ["java", "-jar", "ttrend.jar"]

