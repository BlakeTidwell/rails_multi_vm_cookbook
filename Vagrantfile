# -*- mode: ruby -*-
#
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

# TODO: Investigate service discovery mechanisms. Harcoding these values
# obviously melts down if there are any other devices using these IP addresses
# locally. DHCP is probably preferable.
APP_ADDRESS = '192.168.50.3'
APP_DATABASE_ROLE = 'rails'
APP_DATABASE_PASSWORD = 'rails'

DATABASE_ADDRESS = '192.168.50.4'

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

  # Enabling the Berkshelf plugin. To enable this globally, add this
  # configuration option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  config.vm.define :database do |db|
    db.vm.hostname = 'database'

    db.vm.network "private_network", ip: DATABASE_ADDRESS

    db.vm.provision :chef_solo do |chef|
      chef.json = {
        app: {
          database: {
            user: APP_DATABASE_ROLE,
            password: APP_DATABASE_PASSWORD
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
              user:   APP_DATABASE_ROLE,
              addr:   '127.0.0.1/32',
              method: 'md5'
            },
            {
              type:   'host',
              db:     'all',
              user:   'postgres',
              addr:   "#{APP_ADDRESS}/32",
              method: 'md5'
            },
            {
              type:   'host',
              db:     'all',
              user:   APP_DATABASE_ROLE,
              addr:   "#{APP_ADDRESS}/32",
              method: 'md5'
            }
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

    app.vm.network "private_network", ip: APP_ADDRESS

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

