# zarafa licensed service
class zarafa::licensed::service {
  service { 'zarafa-licensed':
    hasstatus  => true,
    hasrestart => true,
    require    => Class['zarafa::licensed::config'],
  }
}

# enable licensed service
class zarafa::licensed::service::enabled inherits zarafa::licensed::service {
  Service['zarafa-licensed'] { ensure => running }
  zarafa::upstart::enabled { 'licensed': }
}

# disable licensed service
class zarafa::licensed::service::disabled inherits zarafa::licensed::service {
  Service['zarafa-licensed'] { ensure => stopped }
  zarafa::upstart::disabled { 'licensed': }
}

