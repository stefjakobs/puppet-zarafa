# apache2 configuration parameters
class apache2::params {

  case $environment {
    'testing': {
      $apache2_keyprefix     = 'service'
      $apache2_ca_chain_file = 'cacert.pem'
      $apache2_ca_chain_path = ''
    }
    'staging': {
      $apache2_keyprefix     = 'service.qs'
      $apache2_ca_chain_file = 'chain-with-dtag.crt'
      $apache2_ca_chain_path = ''
    }
    'production': {
      $apache2_keyprefix     = 'service.prod'
      $apache2_ca_chain_file = 'chain-with-dtag.crt'
      $apache2_ca_chain_path = ''
    }
    default: {
      fail("Module ${module_name} is not supported in env ${::environment}")
    }
  }

  $apache2_keypath        = '/etc/apache2/ssl'
  $apache2_owner          = 'root'
  $apache2_group          = 'root'
  $apache2_mods_ena       = '/etc/apache2/mods-enabled'
  $apache2_sites_ena      = '/etc/apache2/sites-enabled'

  $apache2_log_level      = 'warn'
  $apache2_log_facility   = 'local1'
  $apache2_log_priority   = 'notice'
  $apache2_log_tag_socket = 'apache2_socket'
  $apache2_log_tag_no_ssl = 'apache2_no_ssl'
  $apache2_log_tag_ssl    = 'apache2_ssl'
}
