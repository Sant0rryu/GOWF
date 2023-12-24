Vagrant.configure("2") do |config|
  boxes = [
            { :name => "GOWF2",  :ip => "192.168.56.10", :box => "kalilinux/rolling", :os => "linux"}
          ]

  config.vm.provider "virtualbox" do |v|
    v.memory = 4000
    v.cpus = 2
  end


  boxes.each do |box|
      config.vm.define box[:name] do |target|
        target.vm.provider "virtualbox" do |v|
        v.name = box[:name]
        end
      target.vm.box_download_insecure = box[:box]
      target.vm.box = box[:box]


      target.vm.network :private_network, ip: box[:ip]
      target.vm.provision "ansible" do |ansible| 
        ansible.playbook="gowf-playbook.yaml" 
      end
      end
  end
end
