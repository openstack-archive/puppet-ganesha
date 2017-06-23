# == Class: ganesha::config
#
# This class is used to manage arbitrary ganesha configurations.
#
# === Parameters
#
# [*ganesha_config*]
#   (optional) Allow configuration of arbitrary ganesha configurations.
#   The value is an hash of ganesha_config resources. Example:
#   { 'DEFAULT/foo' => { value => 'fooValue'},
#     'DEFAULT/bar' => { value => 'barValue'}
#   }
#   In yaml format, Example:
#   ganesha_config:
#     DEFAULT/foo:
#       value: fooValue
#     DEFAULT/bar:
#       value: barValue
#
#   NOTE: The configuration MUST NOT be already handled by this module
#   or Puppet catalog compilation will fail with duplicate resources.
#
class ganesha::config (
  $ganesha_config = {},
) {

  validate_hash($ganesha_config)

  create_resources('ganesha_config', $ganesha_config)
}
