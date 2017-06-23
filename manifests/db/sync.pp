#
# Class to execute ganesha-manage db_sync
#
# == Parameters
#
# [*extra_params*]
#   (optional) String of extra command line parameters to append
#   to the ganesha-dbsync command.
#   Defaults to undef
#
class ganesha::db::sync(
  $extra_params  = undef,
) {
  exec { 'ganesha-db-sync':
    command     => "ganesha-manage db_sync ${extra_params}",
    path        => [ '/bin', '/usr/bin', ],
    user        => 'ganesha',
    refreshonly => true,
    try_sleep   => 5,
    tries       => 10,
    logoutput   => on_failure,
    subscribe   => [Package['ganesha'], Ganesha_config['database/connection']],
  }

  Exec['ganesha-manage db_sync'] ~> Service<| title == 'ganesha' |>
}
