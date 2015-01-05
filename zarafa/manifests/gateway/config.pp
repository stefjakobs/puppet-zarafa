# zarafa-gateway configuration files
class zarafa::gateway::config (
  $server_bind           = '0.0.0.0',
  $server_socket         = $zarafa::params::server_socket,
  $server_hostname       = $zarafa::params::gateway_server_hostname,
  $coredump_enabled      = $zarafa::params::coredump_enabled,
  $pop3_enable           = 'yes',
  $pop3_port             = '110',
  $pop3s_enable          = 'no',
  $pop3s_port            = '995',
  $imap_enable           = 'yes',
  $imap_port             = '143',
  $imaps_enable          = 'no',
  $imaps_port            = '993',
  $imap_only_mailfolders = 'yes',
  $imap_public_folders   = 'no',
  $imap_capability_idle  = 'yes',
  $imap_max_messagesize  = '30M',
){
  include zarafa::gateway_cert

  File {
    ensure  => present,
    owner   => $zarafa::params::zarafa_user,
    group   => $zarafa::params::zarafa_group,
    mode    => '0440',
    require => Class['zarafa::gateway::install'],
    notify  => Class['zarafa::gateway::service'],
  }

  file {
    "${zarafa::params::config_dir}/gateway.cfg":
      content => template('zarafa/gateway/gateway.cfg.erb');

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/gateway.cfg.dpkg-dist":
      ensure  => absent;
    '/etc/init.d/zarafa-gateway.dpkg-new':
      ensure  => absent;
  }
}
