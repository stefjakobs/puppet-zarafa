# zarafa gateway service
# pop3 and imap server
class zarafa::gateway::service {
  service { 'zarafa-gateway':
    hasstatus  => true,
    hasrestart => true,
    require    => Class['zarafa::gateway::config'],
  }
}

# enable zarafa gateway service
class zarafa::gateway::service::enabled inherits zarafa::gateway::service {
  Service['zarafa-gateway'] { ensure => running}
  zarafa::upstart::enabled { 'gateway': }
}

# disable zarafa gateway service
class zarafa::gateway::service::disabled inherits zarafa::gateway::service {
  Service['zarafa-gateway'] { ensure => stopped }
  zarafa::upstart::disabled { 'gateway': }
}
