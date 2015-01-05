# zarafa monitor service
# sends notification mails to users
class zarafa::monitor::service {
  service { 'zarafa-monitor':
    hasstatus  => true,
    hasrestart => true,
    require    => Class['zarafa::monitor::config'],
  }
}

# enable monitor service
class zarafa::monitor::service::enabled inherits zarafa::monitor::service {
  Service['zarafa-monitor'] { ensure => running}
  zarafa::upstart::enabled { 'monitor': }
}

# disable monitor service
class zarafa::monitor::service::disabled inherits zarafa::monitor::service {
  Service['zarafa-monitor'] { ensure => stopped}
  zarafa::upstart::disabled { 'monitor': }
}
