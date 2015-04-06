name             'rails_multi_vm'
maintainer       'Blake Tidwell'
maintainer_email 'YOUR_EMAIL'
license          'Apache 2 License'
description      'Installs/Configures rails_multi_vm'
long_description 'Installs/Configures rails_multi_vm'
version          '0.1.0'

# Shared
depends          'apt', '~> 2.7.0'

# Database
depends          'database', '~> 4.0.0'
depends          'postgresql', '~> 3.4.0'

# App
depends          'build-essential', '~> 2.2.0'
depends          'ruby_build', '~> 0.8.0'
depends          'rbenv', '~> 0.7.2'
