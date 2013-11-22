# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

DB = true
DBNAME = 'database'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "wheezy64"

    config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box"

    config.vm.network "private_network", ip: "33.33.33.33"

    config.vm.network :forwarded_port, guest: 80, host: 8080

    config.vm.synced_folder "./", "/vagrant", id: "vagrant-root", :owner => "vagrant", :group => "www-data"

    #laravel-specific mounts - storage
    config.vm.synced_folder "./app/storage", "/vagrant/app/storage", id: "vagrant-storage",
        :owner => "vagrant",
        :group => "www-data",
        :mount_options => ["dmode=775","fmode=664"]

    #laravel-specific mounts - public
    config.vm.synced_folder "./public", "/vagrant/public", id: "vagrant-public",
        :owner => "vagrant",
        :group => "www-data",
        :mount_options => ["dmode=775","fmode=664"]

    config.vm.provision :shell do |shell|
        shell.path = "vagrant/provision.sh"
        shell.args = DB ? "db " + DBNAME : ""
    end

    # If true, then any SSH connections made will enable agent forwarding.
    # Default value: false
    # config.ssh.forward_agent = true

    # Share an additional folder to the guest VM. The first argument is
    # the path on the host to the actual folder. The second argument is
    # the path on the guest to mount the folder. And the optional third
    # argument is a set of non-required options.
    # config.vm.synced_folder "../data", "/vagrant_data"
end
