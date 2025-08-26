#!/bin/bash
# provision-java.sh - Instalação específica para Java

set -e

print_status() { echo -e "\033[0;32m[INFO]\033[0m $1"; }

print_status "[provision] 🔧 Configurando ambiente Java 21..."

# Instalar Java 21 from official repository
sudo apt-get update -y
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt-get update -y
sudo apt-get install -y openjdk-21-jdk

# Instalar build tools
print_status "[provision] 🔧 Instalando Maven e gradle..."
sudo apt-get install -y maven gradle

# Configurar environment
echo "export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64" >>~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >>~/.bashrc
source ~/.bashrc

# Instalar ferramentas de desenvolvimento
print_status "[provision] 🔧 Instalando Ferramentas de desenvolvimento..."
sudo apt-get install -y \
  git \
  curl \
  wget \
  unzip \
  tree \
  htop

# Verificar instalações
print_status "[provision] ✅ Java instalado:"
java -version
print_status "[provision] ✅ Maven:"
mvn --version
print_status "[provision]✅ Gradle:"
gradle --version

print_status "[provision]🎉 Ambiente Java pronto!"
