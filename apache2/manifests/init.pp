# everything that is needed to have a running apache2 service
class apache2 (
  $namevirtualhost = '',
  $service_cert    = $apache2::params::apache2_keyprefix,
  $keypath         = $apache2::params::apache2_keypath,
  $ca_chain_file   = $apache2::params::apache2_ca_chain_file,
  $owner           = $apache2::params::apache2_owner,
  $group           = $apache2::params::apache2_group,
) {
  include apache2::params
  include apache2::install, apache2::service
  class { 'apache2::config':
    namevirtualhost => $apache2::namevirtualhost,
    service_cert    => $apache2::service_cert,
    keypath         => $apache2::keypath,
    ca_chain_file   => $apache2::ca_chain_file,
    owner           => $apache2::owner,
    group           => $apache2::group,
  }
}

