require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('app') do
  it { should be_enabled  }
  it { should be_running  }
end

describe service('mailcatcher') do
  it { should be_enabled  }
  it { should be_running  }
end

