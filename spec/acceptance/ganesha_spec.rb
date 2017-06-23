require 'spec_helper_acceptance'

describe 'basic ganesha' do

  context 'default parameters' do

    it 'should install ganesha server' do
      pp = <<-EOS
        if $::operatingsystem == 'CentOS' {
          class { '::ganesha':
            # TODO use nightly 2.5 builds for now
            repo_url => 'https://shaman.ceph.com/api/repos/nfs-ganesha/next/latest/centos/7/flavors/ceph_master/repo',
          }
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe port(2049) do
      it { is_expected.to be_listening }
    end
  end

end
