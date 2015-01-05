# install zarafa-ical
class zarafa::ical::install inherits zarafa::common {
  package { 'zarafa-ical':
    ensure  => $zarafa::params::zarafa_version,
  }
  zarafa::upstart { 'ical': }
}

