require 'spec_helper'

describe file('/etc/hosts') do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

users = %w[user1 user2]
users.each do |user|
  context "User #{user} is setup properly" do
    describe user(user.to_s) do
      it { should exist }
    end

    describe file("/home/#{user}/.ssh") do
      it { should be_directory }
    end

    describe file("/home/#{user}/.ssh/authorized_keys") do
      it { should be_file }
      it { should be_owned_by user.to_s }
      it { should be_grouped_into user.to_s }
      it { should be_mode '600' }
    end

    context "User #{user} can sudo" do
      let(:sudo_options) { '-i' }

      describe command('whoami') do
        its(:stdout) { should match 'root' }
      end
    end
  end
end
