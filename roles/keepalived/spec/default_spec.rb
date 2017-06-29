require 'spec_helper'

context 'Keepalived should run propertly' do
  describe file('/etc/keepalived/keepalived.conf') do
    it { should be_file }
    it { should be_owned_by 'keepalived' }
    it { should be_grouped_into 'keepalived' }
  end

  describe host('10.0.1.66') do
    it { should be_reachable }
  end

  describe service('keepalived') do
    it { should be_enabled }
  end
end
