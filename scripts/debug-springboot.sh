#!/bin/bash
# debug-springboot.sh - Debug Spring Boot

cd /home/vagrant/java-project

if [ -f "pom.xml" ]; then
  ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
elif [ -f "build.gradle" ]; then
  ./gradlew bootRun --debug-jvm
fi
