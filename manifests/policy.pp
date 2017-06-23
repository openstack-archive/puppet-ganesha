# == Class: ganesha::policy
#
# Configure the ganesha policies
#
# === Parameters
#
# [*policies*]
#   (optional) Set of policies to configure for ganesha
#   Example :
#     {
#       'ganesha-context_is_admin' => {
#         'key' => 'context_is_admin',
#         'value' => 'true'
#       },
#       'ganesha-default' => {
#         'key' => 'default',
#         'value' => 'rule:admin_or_owner'
#       }
#     }
#   Defaults to empty hash.
#
# [*policy_path*]
#   (optional) Path to the nova policy.json file
#   Defaults to /etc/ganesha/policy.json
#
class ganesha::policy (
  $policies    = {},
  $policy_path = '/etc/ganesha/policy.json',
) {

  validate_hash($policies)

  Openstacklib::Policy::Base {
    file_path => $policy_path,
  }

  create_resources('openstacklib::policy::base', $policies)

  oslo::policy { 'ganesha_config': policy_file => $policy_path }

}
