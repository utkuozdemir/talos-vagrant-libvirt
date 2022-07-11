LOGS_DIR = File.dirname(__FILE__) + "/logs/"
ISO_PATH = File.dirname(__FILE__) + "/talos-amd64.iso"

Vagrant.configure("2") do |config|
  config.vm.provider :libvirt do |libvirt|
    libvirt.management_network_name = "talos-vagrant-libvirt-mgmt"
    libvirt.management_network_keep = true
  end

  config.vm.define "vm-1" do |vm|
    vm.vm.provider :libvirt do |domain|
      domain.cpus = 2
      domain.memory = 2048
      domain.management_network_mac = "02:00:00:00:00:01"
      domain.serial :type => "file", :source => {:path => LOGS_DIR + "vm-1.log"}
      domain.storage :file, :device => :cdrom, :path => ISO_PATH
      domain.storage :file, :size => '16G', :type => 'raw'
      domain.boot 'hd'
      domain.boot 'cdrom'
    end
  end

  config.vm.define "vm-2" do |vm|
    vm.vm.provider :libvirt do |domain|
      domain.cpus = 2
      domain.memory = 2048
      domain.management_network_mac = "02:00:00:00:00:02"
      domain.serial :type => "file", :source => {:path => LOGS_DIR + "vm-2.log"}
      domain.storage :file, :device => :cdrom, :path => ISO_PATH
      domain.storage :file, :size => '16G', :type => 'raw'
      domain.boot 'hd'
      domain.boot 'cdrom'
    end
  end

  config.vm.define "vm-3" do |vm|
    vm.vm.provider :libvirt do |domain|
      domain.cpus = 2
      domain.memory = 2048
      domain.management_network_mac = "02:00:00:00:00:03"
      domain.serial :type => "file", :source => {:path => LOGS_DIR + "vm-3.log"}
      domain.storage :file, :device => :cdrom, :path => ISO_PATH
      domain.storage :file, :size => '16G', :type => 'raw'
      domain.boot 'hd'
      domain.boot 'cdrom'
    end
  end

  config.vm.define "vm-4" do |vm|
    vm.vm.provider :libvirt do |domain|
      domain.cpus = 2
      domain.memory = 2048
      domain.management_network_mac = "02:00:00:00:00:04"
      domain.serial :type => "file", :source => {:path => LOGS_DIR + "vm-4.log"}
      domain.storage :file, :device => :cdrom, :path => ISO_PATH
      domain.storage :file, :size => '16G', :type => 'raw'
      domain.boot 'hd'
      domain.boot 'cdrom'
    end
  end

  config.vm.define "vm-5" do |vm|
    vm.vm.provider :libvirt do |domain|
      domain.cpus = 2
      domain.memory = 2048
      domain.management_network_mac = "02:00:00:00:00:05"
      domain.serial :type => "file", :source => {:path => LOGS_DIR + "vm-5.log"}
      domain.storage :file, :device => :cdrom, :path => ISO_PATH
      domain.storage :file, :size => '16G', :type => 'raw'
      domain.boot 'hd'
      domain.boot 'cdrom'
    end
  end
end
