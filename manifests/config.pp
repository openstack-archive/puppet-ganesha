# == Class ganesha::config
#
# This class handles ganesha config changes.
#
class ganesha::config {
  file { '/etc/ganesha':
    ensure  => directory,
    owner   => 0,
    group   => 0,
    mode    => '0775',
    recurse => true,
  }

  file { '/etc/ganesha/export.d':
    ensure  => directory,
    owner   => 0,
    group   => 0,
    mode    => '0775',
    recurse => true,
  }

  file { '/etc/ganesha/ganesha.conf':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
    content => template('ganesha/ganesha.conf.erb'),
  }

  file { '/etc/ganesha/export.d/INDEX.conf':
    ensure  => file,
    owner   => 0,
    group   => 0,
    mode    => '0644',
  }
}
