require 'spec_helper'

describe 'ganesha::config' do
  context 'with config_file param' do
    let :params do
      {
       :config_file => 'some configuration',
      }
    end

    it { is_expected.to contain_file('/etc/ganesha/ganesha.conf') }
  end

end
