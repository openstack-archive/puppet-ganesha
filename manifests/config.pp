# == Class ganesha::config
#
# This class handles ganesha config changes.
#
# === Parameters
# [*config_file*] If set, then its content is written into
#   /etc/ganesha/ganesha.conf.
#   Optional. Defaults to undef
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
