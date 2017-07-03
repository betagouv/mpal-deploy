require 'spec_helper'

context 'When on redis slave' do
  describe file('/etc/redis/redis.conf') do
    it { should contain 'SLAVEOF MANAGED BY ANSIBLE' }
    it { should contain 'MASTERAUTH MANAGED BY ANSIBLE' }
  end
end
