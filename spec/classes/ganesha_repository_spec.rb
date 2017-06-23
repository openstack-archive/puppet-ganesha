require 'spec_helper'

describe 'ganesha::repository' do
  let :facts do
    OSDefaults.get_facts({
      :osfamily                  => 'RedHat',
      :operatingsystem           => 'CentOS',
      :operatingsystemmajrelease => '7',
    })
  end

  context 'with repo url' do
    let :params do
      {
       :repo_url => 'some_repo',
      }
    end

    it { is_expected.to contain_file('/etc/yum.repos.d/ganesha.repo') }
  end

  context 'with yum_base_url' do
    let :params do
      {
       :yum_base_url => 'base_url',
      }
    end

    it { is_expected.to contain_yumrepo('ganesha').with(
      'baseurl'  => 'base_url',
      'name'     => 'ganesha',
      'enabled'  => 1,
      'gpgcheck' => 0,
    ) }
  end
end
