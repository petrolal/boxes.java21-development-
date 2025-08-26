Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"  # Ubuntu 22.04 LTS (com suporte a Java 21)
  
  # 🔧 Configurações de Rede para Spring Boot
  config.vm.network "forwarded_port", guest: 8080, host: 8080   # Spring Boot
  config.vm.network "forwarded_port", guest: 9090, host: 9090   # Admin/Actuator
  config.vm.network "forwarded_port", guest: 5005, host: 5005   # Debug Java
  
  # 📁 Sincronização de pasta (Spring Boot project)
  config.vm.synced_folder "./java-project", "/home/vagrant/java-project", type: "rsync",
    rsync__args: ["--verbose", "--archive", "--delete", "-z"],
    rsync__exclude: [
      ".git/", ".gradle/", ".m2/", "build/", "target/",
      "*.log", "*.tmp", ".DS_Store", ".idea/", "*.iml"
    ]
  
  # 💻 Configurações de Hardware
  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = 4096  # 4GB RAM para Java
    libvirt.cpus = 4       # 4 CPUs
    libvirt.driver = "kvm"
  end
  
  # 📦 Provisionamento: Java 21 + Ferramentas
  config.vm.provision "shell", inline: <<-SHELL
    echo "🚀 Instalando Java 21 e Spring Boot environment..."
    
    # Atualizar sistema
    apt-get update -y
    apt-get upgrade -y
    
    # Instalar Java 21 (OpenJDK)
    apt-get install -y openjdk-21-jdk maven gradle
    
    # Verificar instalação
    echo "✅ Java Version:"
    java -version
    echo "✅ Maven Version:"
    mvn --version
    echo "✅ Gradle Version:"
    gradle --version
    
    # Instalar ferramentas úteis
    apt-get install -y git curl wget unzip
    
    # Configurar environment Java
    echo 'export JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64' >> /home/vagrant/.bashrc
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/vagrant/.bashrc
    
    # Instalar SDKMAN! (opcional - para gerenciar versões Java)
    curl -s "https://get.sdkman.io" | bash
    source "/home/vagrant/.sdkman/bin/sdkman-init.sh"
    
    # Instalar Spring Boot CLI (opcional)
    sdk install springboot
    
    # Criar diretório do projeto
    mkdir -p /home/vagrant/java-project
    
    echo "🎉 Ambiente Java 21 + Spring Boot configurado!"
  SHELL
  
  # 🔄 Pós-provisionamento
  config.trigger.after :up do |trigger|
    trigger.run = {inline: "echo '📦 Sincronizando arquivos Java...'; vagrant rsync"}
  end
end
