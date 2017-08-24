require 'spec_helper'

context 'Webapps should be properly installed' do

    describe user('mpal') do
      it { should exist }
    end

    describe group('mpal') do
      it { should exist }
    end
  end

  describe file('/home/mpal/mpal-webapp') do
    it { should be_directory }
  end

  describe file('/etc/systemd/systemd/mpal-web.')

end
