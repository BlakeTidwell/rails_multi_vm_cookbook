# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Set the version of chef to install using the vagrant-omnibus plugin
  # NOTE: You will need to install the vagrant-omnibus plugin:
  #
  #   $ vagrant plugin install vagrant-omnibus
  #
  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = 'latest'
  end

  # Every Vagrant virtual environment requires a box to build off of.
  # If this value is a shorthand to a box in Vagrant Cloud then
  # config.vm.box_url doesn't need to be specified.
  config.vm.box = 'ubuntu-12.04-amd64'

  config.vm.synced_folder "test/fixtures/rails_app", "/srv/app"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, type: 'dhcp'

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  database_user = 'rails'
  config.vm.define :database do |db|
    db.vm.hostname = 'database'

    db.vm.provision :chef_solo do |chef|
      chef.json = {
        app: {
          database: {
            user: database_user,
            password: 'rails'
          }
        },
        postgresql: {
          password: {
            postgres: '5d30a314a0f9dce30170db5ba25fd195'
          },
          config: {
            listen_addresses: '0.0.0.0'
          },
          pg_hba: [
            {
              type:   'host',
              db:     'all',
              user:   'postgres',
              addr:   '127.0.0.1/32',
              method: 'md5'
            },
            {
              type:   'host',
              db:     'all',
              user:   database_user,
              addr:   '127.0.0.1/32',
              method: 'md5'
            },
          ]
        }
      }

      chef.run_list = [
        'recipe[rails_multi_vm::database]'
      ]
    end
  end

  config.vm.define :app do |app|
    app.vm.hostname = 'application'
    app.vm.provision :chef_solo do |chef|
      chef.json = {
        app: {
          name: 'app',
          root: '/srv'
        },
        rbenv: {
          global: '2.2.1',
          rubies: ['2.2.1'],
          gems: {
            '2.2.1' => [
              { name: 'bundler' },
              { name: 'foreman' },
              { name: 'mailcatcher' }
            ]
          }
        },
        ruby_build: {
          upgrade: 'true'
        }
      }

      chef.run_list = [
        'recipe[ruby_build]',
        'recipe[rails_multi_vm::app]'
      ]
    end
  end
end
