# == Class ganesha::install
#
# Manages the installation of ganesha.
#
# === Parameters
#
# [*manage_repo*] Whether we should manage the local repository (true) or depend
#   on what is available (false). Set this to false when you want to manage the
#   the repo by yourself.
#   Optional. Defaults to $::ganesha::manage_repo
#
# [*ceph_fsal*] Install Ceph FSAL which can be used with nfs ganesha.
#   Optional. Defaults to $::ganesha::ceph_fsal

class ganesha::install (
  $manage_repo = $::ganesha::manage_repo,
  $ceph_fsal = $::ganesha::ceph_fsal,
) {
  if $manage_repo {
    require ::ganesha::repository
  }

  package { 'nfs-ganesha':
    ensure  => present,
  }

  if $ceph_fsal {
    package { 'nfs-ganesha-ceph':
      ensure  => present,
    }
  }
}
