require 'spec_helper'

describe file('/etc/hosts') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

context 'PostgreSQL should run properly' do
  describe file('/etc/postgresql/9.4/main/postgresql.conf') do
    it { should be_file }
    it { should be_owned_by 'postgres' }
    it { should be_grouped_into 'postgres' }
    it { should contain 'listen_addresses = *' }
    it { should contain 'port = 5432' }
  end

  describe service('postgresql') do
    it { should be_enabled }
  end
end
