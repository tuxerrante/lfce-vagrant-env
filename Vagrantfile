nodes = [
  { :hostname => "box",   :ip => "10.0.0.100", ssh_host_port: 2221, :box => "centos/7", :ram => 512 },
  { :hostname => "node1", :ip => "10.0.0.101", ssh_host_port: 2222, :box => "centos/7", :ram => 1024 },
  { :hostname => "node2", :ip => "10.0.0.102", ssh_host_port: 2223, :box => "centos/7", :ram => 512 },
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      # nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname]
      nodeconfig.vm.network "private_network", ip: node[:ip]
      nodeconfig.vm.network "forwarded_port", guest: 22, host: node[:ssh_host_port], id: "ssh"
      nodeconfig.ssh.insert_key = false # uses vagrant insecure key

      nodeconfig.vm.provision "common", type: "shell", path: "provisioners/common.sh"
      if File.file?("provisioners/#{node[:hostname]}.sh")
        nodeconfig.vm.provision node[:hostname], type: "shell", path: "provisioners/#{node[:hostname]}.sh"
      end

      nodeconfig.vm.provider "docker" do |vb|
        vb.memory = node[:ram]
        vb.cpus = 1
        vb.image="centos:7"
      end

      nodeconfig.vm.provider "virtualbox" do |vb|
        vb.box = node[:box]
        vb.memory = node[:ram]
        vb.cpus = 1
      end

    end
  end
end