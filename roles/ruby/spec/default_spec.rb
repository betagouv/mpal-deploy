require 'spec_helper'

context 'Ruby should be properly installed' do
  packages = %w[libssl-dev zlib1g-dev libreadline-dev libgdbm-dev libcurl4-openssl-dev libicu-dev libpq-dev ]
  packages.each do |package|
    describe package(package.to_s) do
      it { should be_installed }
    end
  end

  describe command('ruby -v') do
    its(:stdout) { should contain 'ruby 2.3.1' }
  end

  describe file('/tmp/ruby-2.3.1.tar.bz2') do
    it { should_not be_file }
  end

  describe file('/tmp/ruby-2.3.1') do
    it { should_not be_file }
    it { should_not be_directory }
  end
end
