#
# Unit tests for ganesha::keystone::auth
#

require 'spec_helper'

describe 'ganesha::keystone::auth' do
  shared_examples_for 'ganesha-keystone-auth' do
    context 'with default class parameters' do
      let :params do
        { :password => 'ganesha_password',
          :tenant   => 'foobar' }
      end

      it { is_expected.to contain_keystone_user('ganesha').with(
        :ensure   => 'present',
        :password => 'ganesha_password',
      ) }

      it { is_expected.to contain_keystone_user_role('ganesha@foobar').with(
        :ensure  => 'present',
        :roles   => ['admin']
      )}

      it { is_expected.to contain_keystone_service('ganesha::FIXME').with(
        :ensure      => 'present',
        :description => 'ganesha FIXME Service'
      ) }

      it { is_expected.to contain_keystone_endpoint('RegionOne/ganesha::FIXME').with(
        :ensure       => 'present',
        :public_url   => 'http://127.0.0.1:FIXME',
        :admin_url    => 'http://127.0.0.1:FIXME',
        :internal_url => 'http://127.0.0.1:FIXME',
      ) }
    end

    context 'when overriding URL parameters' do
      let :params do
        { :password     => 'ganesha_password',
          :public_url   => 'https://10.10.10.10:80',
          :internal_url => 'http://10.10.10.11:81',
          :admin_url    => 'http://10.10.10.12:81', }
      end

      it { is_expected.to contain_keystone_endpoint('RegionOne/ganesha::FIXME').with(
        :ensure       => 'present',
        :public_url   => 'https://10.10.10.10:80',
        :internal_url => 'http://10.10.10.11:81',
        :admin_url    => 'http://10.10.10.12:81',
      ) }
    end

    context 'when overriding auth name' do
      let :params do
        { :password => 'foo',
          :auth_name => 'ganeshay' }
      end

      it { is_expected.to contain_keystone_user('ganeshay') }
      it { is_expected.to contain_keystone_user_role('ganeshay@services') }
      it { is_expected.to contain_keystone_service('ganesha::FIXME') }
      it { is_expected.to contain_keystone_endpoint('RegionOne/ganesha::FIXME') }
    end

    context 'when overriding service name' do
      let :params do
        { :service_name => 'ganesha_service',
          :auth_name    => 'ganesha',
          :password     => 'ganesha_password' }
      end

      it { is_expected.to contain_keystone_user('ganesha') }
      it { is_expected.to contain_keystone_user_role('ganesha@services') }
      it { is_expected.to contain_keystone_service('ganesha_service::FIXME') }
      it { is_expected.to contain_keystone_endpoint('RegionOne/ganesha_service::FIXME') }
    end

    context 'when disabling user configuration' do

      let :params do
        {
          :password       => 'ganesha_password',
          :configure_user => false
        }
      end

      it { is_expected.not_to contain_keystone_user('ganesha') }
      it { is_expected.to contain_keystone_user_role('ganesha@services') }
      it { is_expected.to contain_keystone_service('ganesha::FIXME').with(
        :ensure      => 'present',
        :description => 'ganesha FIXME Service'
      ) }

    end

    context 'when disabling user and user role configuration' do

      let :params do
        {
          :password            => 'ganesha_password',
          :configure_user      => false,
          :configure_user_role => false
        }
      end

      it { is_expected.not_to contain_keystone_user('ganesha') }
      it { is_expected.not_to contain_keystone_user_role('ganesha@services') }
      it { is_expected.to contain_keystone_service('ganesha::FIXME').with(
        :ensure      => 'present',
        :description => 'ganesha FIXME Service'
      ) }

    end

    context 'when using ensure absent' do

      let :params do
        {
          :password => 'ganesha_password',
          :ensure   => 'absent'
        }
      end

      it { is_expected.to contain_keystone__resource__service_identity('ganesha').with_ensure('absent') }

    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'ganesha-keystone-auth'
    end
  end
end
