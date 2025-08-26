Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"  # Ubuntu 22.04 LTS (com suporte a Java 21)
  
  # 🔧 Configurações de Rede para Spring Boot
  config.vm.network "forwarded_port", guest: 8080, host: 8080   # Spring Boot
  config.vm.network "forwarded_port", guest: 5005, host: 5005   # Debug Java
  config.vm.network "forwarded_port", guest: 9092, host: 9092   # Bff Projects
  config.vm.network "forwarded_port", guest: 9090, host: 9090   # Admin/Actuator
  
  # 📁 Sincronização de pasta (Spring Boot project)
  config.vm.synced_folder "./shared", "/vagrant", type: "rsync",
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
  config.vm.provision "shell", path: "provision.sh"
  
  # 🔄 Pós-provisionamento
  config.trigger.after :up do |trigger|
    trigger.run = {inline: "echo '📦 Sincronizando arquivos Java...'; vagrant rsync"}
  end
end
