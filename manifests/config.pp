# == Class ganesha::config
#
# This class handles ganesha config changes.
#
class ganesha::config (
  $config_file = $::ganesha::config_file
) {
  if $config_file {
    file { '/etc/ganesha/ganesha.conf':
      ensure  => file,
      owner   => 0,
      group   => 0,
      mode    => '0644',
      content => $config_file,
    }
  }
}
