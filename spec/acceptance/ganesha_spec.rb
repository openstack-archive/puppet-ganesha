require 'spec_helper_acceptance'

describe 'basic ganesha' do

  context 'default parameters' do

    it 'should install ganesha server' do
      pp = <<-EOS
        if $::operatingsystem == 'CentOS' {
          class { '::ganesha':
            yum_base_url => 'http://download.ceph.com/nfs-ganesha/rpm-V2.5-stable/el7/$basearch/',
          }
        } else {
          # TODO: shaman's repos use https which is not supported by apt
          # if apt-transport-https package is missing
          package { 'apt-transport-https':
            ensure  => present,
          }
          # TODO: for nightly nfs-ganesha builds also a ceph nightly build repo
          # is needed
          file { '/etc/apt/sources.list.d/ganesha.list':
            ensure => present,
            source => 'https://shaman.ceph.com/api/repos/ceph/master/latest/ubuntu/xenial/repo',
          }

          class { '::ganesha':
            repo_url => 'https://shaman.ceph.com/api/repos/nfs-ganesha/next/latest/ubuntu/xenial/flavors/ceph_master/repo',
          }
        }
      EOS

      apply_manifest(pp, :catch_failures => true)
      # Run it twice and test for idempotency
      # TODO: ubuntu now relies on nightly builds, fetching
      # its repo always overwrites repo file so there
      # is always change, check for changes on centos for now
      if os[:family].casecmp('RedHat') == 0
        apply_manifest(pp, :catch_changes => true)
      end
    end

    describe port(2049) do
      it { is_expected.to be_listening }
    end
  end

end
