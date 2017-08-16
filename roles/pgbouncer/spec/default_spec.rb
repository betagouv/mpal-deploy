require 'spec_helper'

context 'pgbouncer should be configured properly' do
  describe user('pgbouncer') do
    it { should exist }
  end

  describe group('pgbouncer') do
    it { should exist }
  end

  describe file('/etc/pgbouncer/pgbouncer.ini') do
    it { should be_file }
    it { should be_owned_by 'pgbouncer' }
    it { should be_grouped_into 'pgbouncer' }
    it { should contain 'host=pgbouncer_db_host' }
    it { should contain 'port=pgboucner_db_port' }
    it { should contain 'dbname=pgbouncer_db_name' }
    it { should contain 'listen_port = pg_bouncer_listen_port' }
    it { should contain 'listen_addr = pgbouncer_listen_ip' }
    it { should contain 'admin_users = pgbouncer_admin_users' }
  end
end
