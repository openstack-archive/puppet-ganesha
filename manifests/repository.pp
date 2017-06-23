# == Class ganesha::install
#
# Prepare the ganesha repositories to install packages.
#
# === Parameters
# [*yum_base_url*] Ganesha repository base URL which is used if
#   manage_repo=true.
#   Optional.
#
# [*repo_url*] Ganesha repository URL which is used if manage_repo=true and
#   yum_base_url is not set.
#   Optional.

class ganesha::repository (
  $yum_base_url = $::ganesha::yum_base_url,
  $repo_url = $::ganesha::repo_url,
) {

    case $::operatingsystem {
      'RedHat', 'CentOS': {
        if $repo_url {
          file { '/etc/yum.repos.d/ganesha.repo':
            ensure => present,
            source => $repo_url,
          }
        } elsif $yum_base_url {
          yumrepo { 'ganesha':
            name     => 'ganesha',
            baseurl  => $yum_base_url,
            descr    => 'ganesha packages',
            enabled  => 1,
            gpgcheck => 0,
          }
        }
      }

      'Ubuntu': {
        include apt::update

        # TODO: currently only nightly builds are available
        file { '/etc/apt/sources.list.d/ganesha.list':
          ensure => present,
          source => $repo_url,
        }

        # Required to wrap apt_update
        exec {'update-ganesha-repo':
          refreshonly => true,
          command     => '/bin/true',
          require     => Exec['apt_update'],
        }
      }

      default: {
        fail('Operating system not supported by this module')
      }
  }
}
