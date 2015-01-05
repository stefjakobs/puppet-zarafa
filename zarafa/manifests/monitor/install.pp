# install zarafa-monitor
class zarafa::monitor::install inherits zarafa::common {

  package { 'zarafa-monitor':
    ensure  => $zarafa::params::zarafa_version,
  }
  zarafa::upstart { 'monitor': }
}
