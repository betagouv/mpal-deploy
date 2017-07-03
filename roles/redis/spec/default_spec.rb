require 'spec_helper'

context 'Redis should work properly' do
  describe file('/etc/redis/redis.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end

  describe service('redis-server') do
    it { should be_running }
    it { should be_enabled }
  end
end
