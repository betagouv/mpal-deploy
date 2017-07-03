require 'spec_helper'

context 'On redis master' do
  describe file('/etc/redis/redis.conf') do
    it { should_not contain 'SLAVEOF MANAGED BY ANSIBLE' }
    it { should_not contain 'MASTERAUTH MANAGED BY ANSIBLE' }
  end
end
