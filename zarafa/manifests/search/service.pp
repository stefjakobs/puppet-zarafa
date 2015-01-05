# zarafa search service
class zarafa::search::service {
  service { 'zarafa-search':
    hasstatus  => true,
    hasrestart => true,
    require    => Class['zarafa::search::config'],
  }
}

# enable search service
class zarafa::search::service::enabled inherits zarafa::search::service {
  Service['zarafa-search'] { ensure => running}
  zarafa::upstart::enabled { 'search': }
}

# disable search service
class zarafa::search::service::disabled inherits zarafa::search::service {
  Service['zarafa-search'] { ensure => stopped}
  zarafa::upstart::disabled { 'search': }
}
