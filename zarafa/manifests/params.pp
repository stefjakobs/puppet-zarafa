# zarafa configuration parameters
class zarafa::params {

  case $environment {
    'testing': {
      # Global Options
      $server_socket           = 'https://node.zarafa.example.org:237/zarafa'
      $zarafa_version          = '7.1.11-45875'
      $client_version          = '7.1.11-46779'
      $webapp_version          = '1:2.0b2-46339'
      $zarafa_user             = 'zarafa'
      $zarafa_group            = 'zarafa'
      $config_dir              = '/etc/zarafa'
      $coredump_enabled        = 'yes'

      # Log Options
      $log_level               = '6'
      $log_audit               = 'yes'
      $log_audit_level         = '1'
      $client_update_log_path  = '/var/log/zarafa/autoupdate'

      # SSL Options
      $ssl_dir                 = "${config_dir}/ssl"
      $sslkeys_dir             = "${config_dir}/sslkeys"
      $ssl_server_cert_priv    = "node1.zarafa.example.org-cert.pem"
      $ssl_server_cert_pub     = "node1.zarafa.example.org-public.pem"
      $ssl_key_pass_server     = 'zarafa'

      $ssl_key_file_client     = "${ssl_dir}/client.pem"
      $ssl_key_pass_client     = 'zclient'
      $ssl_pub_file_client     = "${sslkeys_dir}/client-public.pem"

      $ssl_service_priv_key    = 'service.pem'
      $ssl_service_cert        = 'service-cert.pem'
      $ssl_gateway_priv_key    = 'service.pem'
      $ssl_gateway_cert        = 'service-cert.pem'
      $ssl_ca_file             = 'cacert.pem'

      # Server Options
      $mysql_database          = 'zarafa'
      $mysql_zarafa_user       = 'zarafa'
      $mysql_zarafa_password   = 'secret'

      $base_dir                = '/var/lib/zarafa'
      $attachments_dir         = "${base_dir}/attachments"
      $client_dir              = "${base_dir}/client"

      # LDAP Options
      $ldap_port               = '3269'
      $ldap_protocol           = 'ldaps'
      $ldap_network_timeout    = '30'

      # Gateway Options
      $gateway_server_hostname = 'imap.zarafa.example.org'

      # Spooler Optons
      $smtp_server             = 'mail.zarafa.example.org'
    }
    'staging': {
      # Global Options
      $server_socket           = 'https://mail-znode.qs.example.org:237/zarafa'
      $zarafa_version          = '7.1.11-45875'
      $client_version          = '7.1.11-46779'
      $webapp_version          = '1:1.6-45357'
      $zarafa_user             = 'zarafa'
      $zarafa_group            = 'zarafa'
      $config_dir              = '/etc/zarafa'
      $coredump_enabled        = 'yes'

      # Log Options
      $log_level               = '6'
      $log_audit               = 'yes'
      $log_audit_level         = '1'
      $client_update_log_path  = '/var/log/zarafa/autoupdate'

      # SSL Options
      $ssl_dir                 = "${config_dir}/ssl"
      $sslkeys_dir             = "${config_dir}/sslkeys"
      $ssl_server_cert_priv    = "mail-znode-ma1.qs.example.org-cert.pem"
      $ssl_server_cert_pub     = "mail-znode-ma1.qs.example.org-public.pem"
      $ssl_key_pass_server     = 'secret'

      $ssl_key_file_client     = "${ssl_dir}/client.pem"
      $ssl_key_pass_client     = 'secret'
      $ssl_pub_file_client     = "${sslkeys_dir}/client-public.pem"

      $ssl_gateway_priv_key    = 'imap.qs.example.org.pem'
      $ssl_gateway_cert        = 'imap.qs.example.org-cert.pem'
      $ssl_ca_file             = 'chain-with-dtag.crt'

      # Server Options
      $mysql_database          = 'zarafa'
      $mysql_zarafa_user       = 'zarafa'
      $mysql_zarafa_password   = 'secret'

      $base_dir                = '/var/lib/zarafa'
      $attachments_dir         = "${base_dir}/attachments"
      $client_dir              = "${base_dir}/client"

      # LDAP Options
      $ldap_port               = '3269'
      $ldap_protocol           = 'ldaps'
      $ldap_network_timeout    = '30'

      # Gateway Options
      $gateway_server_hostname = 'gateway.qs.example.org'

      # Spooler Optons
      $smtp_server             = 'smtp.qs.example.org'
    }
    'production': {
      # Global Options
      $server_socket           = 'https://mail-znode.example.org:237/zarafa'
      $zarafa_version          = '7.1.11-45875'
      $client_version          = '7.1.11-46779'
      $webapp_version          = '1:1.6-45357'
      $zarafa_user             = 'zarafa'
      $zarafa_group            = 'zarafa'
      $config_dir              = '/etc/zarafa'
      $coredump_enabled        = 'yes'

      # Log Options
      $log_level               = '4'
      $log_audit               = 'no'
      $log_audit_level         = '0'
      $client_update_log_path  = '/var/log/zarafa/autoupdate'

      # SSL Options
      $ssl_dir                 = "${config_dir}/ssl"
      $sslkeys_dir             = "${config_dir}/sslkeys"
      $ssl_server_cert_priv    = "mail-znode-ma1.example.org-cert.pem"
      $ssl_server_cert_pub     = "mail-znode-ma1.example.org-public.pem"
      $ssl_key_pass_server     = 'secret'

      $ssl_key_file_client     = "${ssl_dir}/client.pem"
      $ssl_key_pass_client     = 'secret'
      $ssl_pub_file_client     = "${sslkeys_dir}/client-public.pem"

      $ssl_gateway_priv_key    = 'imap.example.org.pem'
      $ssl_gateway_cert        = 'imap.example.org-cert.pem'
      $ssl_ca_file             = 'chain-with-dtag.crt'

      # Server Options
      $mysql_database          = 'zarafa'
      $mysql_zarafa_user       = 'zarafa'
      $mysql_zarafa_password   = 'secret'

      $base_dir                = '/var/lib/zarafa'
      $attachments_dir         = "${base_dir}/attachments"
      $client_dir              = "${base_dir}/client"

      # LDAP Options
      $ldap_port               = '3269'
      $ldap_protocol           = 'ldaps'
      $ldap_network_timeout    = '30'

      # Gateway Options
      $gateway_server_hostname = 'gateway.example.org'

      # Spooler Optons
      $smtp_server             = 'mr2.example.org'
    }
    default: {
      fail("Module ${module_name} is not supported in env ${::environment}")
    }
  }

  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $zarafa_default_src  = 'default.zarafa'
      $zarafa_default_path = '/etc/default/zarafa'
    }
    /(opensuse|SLES)/: {
      $zarafa_default_src  = 'sysconfig.zarafa'
      $zarafa_default_path = '/etc/sysconfig/zarafa'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
  $firewall_mail_networks = [
    '192.168.1.48/28',
  ]
  $firewall_mail_networksv6 = [
    '2001:db8::/64',
  ]
  $firewall_test_users = [
    '192.168.3.128/26',
  ]
  $firewall_test_usersv6 = [
    '2001:db8::/64',
  ]
}
