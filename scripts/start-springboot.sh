#!/bin/bash
# start-springboot.sh - Inicia aplicação Spring Boot

cd /home/vagrant/java-project

# Verificar se é Maven ou Gradle
if [ -f "pom.xml" ]; then
  echo "🚀 Starting Spring Boot with Maven..."
  ./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Xmx2g -Xms512m"
elif [ -f "build.gradle" ]; then
  echo "🚀 Starting Spring Boot with Gradle..."
  ./gradlew bootRun -Dorg.gradle.jvmargs="-Xmx2g -Xms512m"
else
  echo "❌ No Maven or Gradle project found"
  exit 1
fi
