require 'spec_helper'

context 'Backports repo should be enabled' do
  describe file('/etc/apt/sources.list.d/http_debian_net_debian.list') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should contain 'jessie-backports main' }
  end
end
