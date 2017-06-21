require 'spec_helper'

describe file('/etc/hosts') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

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

def is_redis_master
  command('grep \'SLAVEOF \' /etc/redis/redis.conf').exit_status == 1
end

if is_redis_master do
  context 'When on redis master' do
    describe file('/etc/redis/redis.conf')do
      it { should_not contain 'SLAVEOF MANAGED BY ANSIBLE' }
      it { should_not contain 'MASTERAUTH MANAGED BY ANSIBLE' }
    end
  end
else
  context 'When on redis slave' do
    describe file('/etc/redis/redis.conf')do
      it { should contain 'SLAVEOF MANAGED BY ANSIBLE' }
      it { should contain 'MASTERAUTH MANAGED BY ANSIBLE' }
    end
  end
end
