# zarafa spooler service
# receives mails from users and forwards them to postfix
class zarafa::spooler::service {

  service { 'zarafa-spooler':
    hasstatus  => true,
    hasrestart => true,
    require    => Class['zarafa::spooler::config'],
  }
}

# enable zarafa spooler service
class zarafa::spooler::service::enabled inherits zarafa::spooler::service {
  # enable => false deactivates sysvinit. upstart will start!
  Service['zarafa-spooler'] { ensure => running }
  zarafa::upstart::enabled { 'spooler': }
}

# disable zarafa spooler service
class zarafa::spooler::service::disabled inherits zarafa::spooler::service {
  Service['zarafa-spooler'] { ensure => stopped }
  zarafa::upstart::enabled { 'spooler': }
}
