require 'spec_helper'

describe 'ganesha' do
  let :facts do
    OSDefaults.get_facts({
      :osfamily                  => 'RedHat',
      :operatingsystem           => 'CentOS',
      :operatingsystemmajrelease => '7',
    })
  end

  describe "with default params" do
      it { is_expected.to contain_class('ganesha::params') }
      it { is_expected.to contain_class('ganesha::install') }
      it { is_expected.to contain_class('ganesha::service') }
  end
end
