# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

###########################
# Database configuratiion #
###########################

# What DB server we should install?
# variants: mysql, mariadb, postgresql
DATABASE_TYPE = 'mysql'
DATABASE_ROOT_PASSWORD = 'root'

# Should we create a database for this app?
DATABASE_CREATE = true
DATABASE_NAME = 'database'

# What is the name of environment of this VM?
LOCAL_ENV_NAME = 'dev'


#########################
# Vagrant configuration #
#########################

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "precise64"

    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    config.vm.network "private_network", ip: "33.33.33.33"

    config.vm.network :forwarded_port, guest: 80, host: 8080

    config.vm.synced_folder "./", "/vagrant", id: "vagrant-root",
            :owner => "vagrant",
            :group => "www-data",
            :mount_options => ["dmode=775","fmode=764"]

    config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"


    config.vm.provision :shell do |shell|
        shell.path = "vagrant/provision.sh"
        shell.args = LOCAL_ENV_NAME + " " + DATABASE_TYPE + " " + DATABASE_ROOT_PASSWORD + ( DATABASE_CREATE ? (" " + DATABASE_NAME) : " _null" )
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
