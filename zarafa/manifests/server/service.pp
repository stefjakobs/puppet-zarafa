# zarafa-server service
class zarafa::server::service {

  service { 'zarafa-server':
    hasstatus  => true,
    hasrestart => true,
    require    => [ Class['zarafa::server::config'],
                    Class['z_mysql::service::enabled'],
                  ],
  }
}

# enable zarafa-server service
class zarafa::server::service::enabled inherits zarafa::server::service {
  Service['zarafa-server'] { ensure => running }
  zarafa::upstart::enabled { 'server': }
}

# disable zarafa-server service
class zarafa::server::service::disabled inherits zarafa::server::service {
  Service['zarafa-server'] { ensure => stopped }
  zarafa::upstart::enabled { 'server': }
}
