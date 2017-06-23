# == Class: ganesha
#
# Installs and configures nfs ganesha server
#
# === Parameters
#
# [*manage_repo*] Whether we should manage the local repository (true) or depend
#   on what is available (false). Set this to false if you want to manage the
#   the repo by yourself.
#   Optional. Defaults to true
#
# [*yum_base_url*] Ganesha repository base URL which is used if manage_repo=true
#   Optional.
#
# [*repo_url*] Ganesha repository URL which is used if manage_repo=true and
#   yum_base_url is not set.
#   Optional.
#
# [*ceph_fsal*] Install Ceph FSAL which can be used with nfs ganesha.
#   Optional. Defaults to false.
#
# [*service_ensure*]
#   Chooses whether the ganesha service should be running & enabled at boot, or
#   stopped and disabled at boot. Defaults to 'running'
#
# [*service_manage*]
#   Chooses whether the ganesha service state should be managed by puppet at
#   all. Defaults to true
#
# [*service_enable*]
#   Chooses whether the ganesha service state should be enabled by puppet at
#   all. Defaults to true
#
# [*service_name*]
#   Ganesha service name. Defaults to true

class ganesha (
  $service_enable    = $ganesha::params::service_enable,
  $service_ensure    = $ganesha::params::service_ensure,
  $service_manage    = $ganesha::params::service_manage,
  $service_name      = $ganesha::params::service_name,
  $manage_repo       = $ganesha::params::manage_repo,
  $repo_url          = $ganesha::params::repo_url,
  $yum_base_url      = $ganesha::params::yum_base_url,
  $ceph_fsal         = $ganesha::params::ceph_fsal,
) inherits ::ganesha::params {

  # Validate OS
  case $::operatingsystem {
    'CentOS', 'RedHat': {
      if $::operatingsystemmajrelease != '7' {
        fail("Unsupported OS: ${::operatingsystem} ${::operatingsystemmajrelease}")
      }
    }
    default: {
      fail("Unsupported OS: ${::operatingsystem}")
    }
  }

  class { '::ganesha::install': }
  -> class { '::ganesha::config': }
  ~> class { '::ganesha::service': }
  -> Class['::ganesha']

}
