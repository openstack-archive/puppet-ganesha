require 'spec_helper_acceptance'

describe 'basic ganesha' do

  context 'default parameters' do

    it 'should install ganesha server' do
      pp = <<-EOS
        if $::operatingsystem == 'CentOS' {
          class { '::ganesha':
            yum_base_url => 'http://download.ceph.com/nfs-ganesha/rpm-V2.5-stable/el7/$basearch/',
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
      }
    end

    describe port(2049) do
      it { is_expected.to be_listening }
    end
  end

end
