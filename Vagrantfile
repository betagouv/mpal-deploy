Vagrant.configure(2) do |config|

  config.vm.boot_timeout = 120
  box_image = "debian/jessie64"

  # Append our own public key to log in the VMs.
  id_rsa_key_pub = File.read(File.join(Dir.home, ".ssh", "id_rsa.pub"))
  config.vm.provision :shell, :inline => "echo 'appending SSH Pub Key to ~vagrant/.ssh/authorized_keys' && echo '#{id_rsa_key_pub }' >> /home/vagrant/.ssh/authorized_keys && chmod 600 /home/vagrant/.ssh/authorized_keys"
  config.ssh.insert_key = false

  config.vm.define "load-balancer-1" do |lb|
    lb.vm.box = box_image
    lb.vm.network "private_network", ip: "10.0.1.2"
  end

  config.vm.define "load-balancer-2" do |lb|
    lb.vm.box = box_image
    lb.vm.network "private_network", ip: "10.0.1.3"
  end

  config.vm.define "web-1" do |web|
    web.vm.box = box_image
    web.vm.network "private_network", ip: "10.0.1.4"
  end

  config.vm.define "web-2" do |web|
    web.vm.box = box_image
    web.vm.network "private_network", ip: "10.0.1.5"
  end

  config.vm.define "backends" do |backends|
    backends.vm.box = box_image
    backends.vm.network "private_network", ip: "10.0.1.6"
  end

end
