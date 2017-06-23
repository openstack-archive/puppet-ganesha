# == Class ganesha::params
#
# This class manages the default params for the ganesha class.
#
class ganesha::params {
  $service_enable    = true
  $service_ensure    = 'running'
  $service_manage    = true
  $service_name      = 'nfs-ganesha'
  $manage_repo       = true
  $repo_url          = undef
  $yum_base_url      = undef
  $ceph_fsal         = false
  $config_file       = undef
}
