require 'spec_helper'

describe 'ganesha::install' do
  let :facts do
    OSDefaults.get_facts({
      :osfamily                  => 'RedHat',
      :operatingsystem           => 'CentOS',
      :operatingsystemmajrelease => '7',
    })
  end

  context 'with enabled ceph_fsal' do
    let :params do
      {
       :ceph_fsal => true,
      }
    end

    it { is_expected.to contain_package('nfs-ganesha-ceph').with('ensure'  => 'present') }
  end

  context 'with manage repository' do
    let :params do
      {
       :manage_repo => true,
      }
    end

    it { is_expected.to contain_class('ganesha::repository') }
  end
end
