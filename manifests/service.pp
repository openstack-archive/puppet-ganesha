class ganesha::service inherits ganesha {

  if ! ($ganesha::service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $ganesha::service_manage == true {
    service { 'nfs-ganesha':
      ensure     => $ganesha::service_ensure,
      enable     => $ganesha::service_enable,
      name       => $ganesha::service_name,
      provider   => $ganesha::service_provider,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
