# zarafa dagent service
# receives mail from postfix and stores them in zarafa
class zarafa::dagent::service {

  service { 'zarafa-dagent':
    hasstatus  => true,
    hasrestart => true,
    require    => [ Class['zarafa::dagent::config'], ],
    provider   => upstart
  }
}

# enable zarafa dagent service
class zarafa::dagent::service::enabled inherits zarafa::dagent::service {
  Service['zarafa-dagent'] { ensure => running }
  zarafa::upstart::enabled { 'dagent': }
}

# disable zarafa dagent service
class zarafa::dagent::service::disabled inherits zarafa::dagent::service {
  Service['zarafa-dagent'] { ensure => stopped }
  zarafa::upstart::disabled { 'dagent': }
}

