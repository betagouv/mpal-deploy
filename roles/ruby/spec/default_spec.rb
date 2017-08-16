require 'spec_helper'

context 'Ruby should be properly installed' do
  # rubocop:disable LineLength
  let(:path) { '/home/mpal/.rbenv/bin:/home/mpal/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games' }
  # rubocop:enable LineLength
  set :sudo_options, '-u mpal -i'

  describe command('rbenv global 2.3.1 && ruby -v') do
    its(:stdout) { should contain 'ruby 2.3.1' }
  end
end
