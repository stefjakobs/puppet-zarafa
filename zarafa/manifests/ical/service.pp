# zarafa ical service
# ical server
class zarafa::ical::service {
  service { 'zarafa-ical':
    hasstatus  => true,
    hasrestart => true,
    require    => Class['zarafa::ical::config'],
  }
}

# enable zarafa ical service
class zarafa::ical::service::enabled inherits zarafa::ical::service {
  Service['zarafa-ical'] { ensure => running }
  zarafa::upstart::enabled { 'ical': }
}

# disable zarafa ical service
class zarafa::ical::service::disabled inherits zarafa::ical::service {
  Service['zarafa-ical'] { ensure => stopped }
  zarafa::upstart::disabled { 'ical': }
}

