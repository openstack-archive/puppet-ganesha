require 'spec_helper'

describe 'ganesha::db::sync' do

  shared_examples_for 'ganesha-dbsync' do

    it 'runs ganesha-db-sync' do
      is_expected.to contain_exec('ganesha-db-sync').with(
        :command     => 'ganesha-manage db_sync ',
        :path        => [ '/bin', '/usr/bin', ],
        :refreshonly => 'true',
        :user        => 'ganesha',
        :logoutput   => 'on_failure'
      )
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(OSDefaults.get_facts({
          :os_workers     => 8,
          :concat_basedir => '/var/lib/puppet/concat'
        }))
      end

      it_configures 'ganesha-dbsync'
    end
  end

end
