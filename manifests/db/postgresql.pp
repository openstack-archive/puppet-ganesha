# == Class: ganesha::db::postgresql
#
# Class that configures postgresql for ganesha
# Requires the Puppetlabs postgresql module.
#
# === Parameters
#
# [*password*]
#   (Required) Password to connect to the database.
#
# [*dbname*]
#   (Optional) Name of the database.
#   Defaults to 'ganesha'.
#
# [*user*]
#   (Optional) User to connect to the database.
#   Defaults to 'ganesha'.
#
#  [*encoding*]
#    (Optional) The charset to use for the database.
#    Default to undef.
#
#  [*privileges*]
#    (Optional) Privileges given to the database user.
#    Default to 'ALL'
#
# == Dependencies
#
# == Examples
#
# == Authors
#
# == Copyright
#
class ganesha::db::postgresql(
  $password,
  $dbname     = 'ganesha',
  $user       = 'ganesha',
  $encoding   = undef,
  $privileges = 'ALL',
) {

  Class['ganesha::db::postgresql'] -> Service<| title == 'ganesha' |>

  ::openstacklib::db::postgresql { 'ganesha':
    password_hash => postgresql_password($user, $password),
    dbname        => $dbname,
    user          => $user,
    encoding      => $encoding,
    privileges    => $privileges,
  }

  ::Openstacklib::Db::Postgresql['ganesha'] ~> Exec<| title == 'ganesha-manage db_sync' |>

}
