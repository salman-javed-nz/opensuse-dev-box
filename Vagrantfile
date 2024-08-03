Vagrant.configure("2") do |config|
  config.vm.box = "opensuse/Leap-15.6.x86_64"
  config.vm.provider "virtualbox" do |v|
    v.cpus = 4
    v.memory = 16384
    v.gui = true
    v.customize ["modifyvm", :id, "--vram", "32"]
    v.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
  end
  config.vm.provision :shell, path: "provision.sh"
  config.disksize.size = "120GB"
end
