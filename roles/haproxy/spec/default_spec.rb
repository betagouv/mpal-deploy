require 'spec_helper'

describe file('/etc/hosts') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

context 'HAproxy is properly installed' do
  describe file('/etc/haproxy/haproxy.cfg') do
    it { should be_file }
    it { should be_owned_by 'haproxy' }
    it { should be_grouped_into 'haproxy' }
  end

  describe port(80) do
    it { should be_listening.with('tcp') }
  end

  describe service('haproxy') do
    it { should be_enabled }
  end

  describe file('/etc/sysctl.conf') do
    it { should be_file }
    it { should contain 'net.ipv4.ip_nonlocal_bind=1' }
  end
end
