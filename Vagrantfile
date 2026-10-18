Vagrant.configure("2") do |config|
  config.vm.define "gateway-vm" do |gateway|
    gateway.vm.box = "ubuntu/bionic64"
    gateway.vm.network "public_network", ip: "11.11.90.200", bridge: "en0: Wi-Fi"
    # gateway.vm.network "public_network", ip: "192.168.1.90", bridge: "wlp2s0"
    gateway.vm.provision "shell", path: "scripts/setup_gateway.sh"
  end

  config.vm.define "inventory-vm" do |inventory|
    inventory.vm.box = "ubuntu/bionic64"
    inventory.vm.network "public_network", ip: "11.11.90.201", bridge: "en0: Wi-Fi"
    # inventory.vm.network "public_network", ip: "192.168.1.91", bridge: "wlp2s0"
    inventory.vm.network :forwarded_port, guest: 8080, host: 8080
    inventory.vm.provision "shell", path: "scripts/setup_inventory.sh"
  end

  config.vm.define "billing-vm" do |billing|
    billing.vm.box = "ubuntu/bionic64"
    billing.vm.network "public_network", ip: "11.11.90.202", bridge: "en0: Wi-Fi"
    # billing.vm.network "public_network", ip: "192.168.1.92", bridge: "wlp2s0"
    billing.vm.network "forwarded_port", guest: 15672, host: 15672
    billing.vm.provision "shell", path: "scripts/setup_billing.sh"
  end
end
