#!/bin/bash
# provision-java.sh - Instalação específica para Java

set -e

echo "🔧 Configurando ambiente Java 21..."

# Instalar Java 21 from official repository
sudo apt-get update -y
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get update -y
sudo apt-get install -y openjdk-21-jdk

# Instalar build tools
sudo apt-get install -y maven gradle

# Configurar environment
echo "export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64" >>~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >>~/.bashrc
source ~/.bashrc

# Instalar ferramentas de desenvolvimento
sudo apt-get install -y \
  git \
  curl \
  wget \
  unzip \
  tree \
  htop

# Verificar instalações
echo "✅ Java instalado:"
java -version
echo "✅ Maven:"
mvn --version
echo "✅ Gradle:"
gradle --version

echo "🎉 Ambiente Java pronto!"
