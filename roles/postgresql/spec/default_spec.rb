require 'spec_helper'

# rubocop:disable BlockLength
context 'PostgreSQL should run properly' do
  context 'As root' do
    describe file('/etc/postgresql/9.4/main/postgresql.conf') do
      it { should be_file }
      it { should be_owned_by 'postgres' }
      it { should be_grouped_into 'postgres' }
      it { should contain 'listen_addresses = *' }
      it { should contain 'port = 5432' }
    end

    describe service('postgresql') do
      it { should be_running }
      it { should be_enabled }
    end

    describe user('mpal') do
      it { should exist }
    end

    describe group('mpal') do
      it { should exist }
    end
  end

  context 'As mpal user' do
    let(:sudo_options) { '-u mpal' }

    describe command('/usr/bin/psql -c "\l" | grep mpal') do
      its(:stdout) { should contain 'mpal      | mpal     | UTF8' }
    end

    describe command('/usr/bin/psql -c "\du" | grep mpal') do
      its(:stdout) { should contain 'mpal      | Superuser' }
    end
  end
end
# rubocop:enable BlockLength
