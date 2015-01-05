# install zarafa gateway and enable service
class zarafa::gateway (
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
) {
  include zarafa::gateway::install
  class { 'zarafa::gateway::config':
    server_bind           => $zarafa::gateway::server_bind,
    server_socket         => $zarafa::gateway::server_socket,
    server_hostname       => $zarafa::gateway::server_hostname,
    coredump_enabled      => $zarafa::gateway::coredump_enabled,
    pop3_enable           => $zarafa::gateway::pop3_enable,
    pop3_port             => $zarafa::gateway::pop3_port,
    pop3s_enable          => $zarafa::gateway::pop3s_enable,
    pop3s_port            => $zarafa::gateway::pop3s_port,
    imap_enable           => $zarafa::gateway::imap_enable,
    imap_port             => $zarafa::gateway::imap_port,
    imaps_enable          => $zarafa::gateway::imaps_enable,
    imaps_port            => $zarafa::gateway::imaps_port,
    imap_only_mailfolders => $zarafa::gateway::imap_only_mailfolders,
    imap_public_folders   => $zarafa::gateway::imap_public_folders,
    imap_capability_idle  => $zarafa::gateway::imap_capability_idle,
    imap_max_messagesize  => $zarafa::gateway::imap_max_messagesize,
  }
  include zarafa::gateway::service::enabled
}
