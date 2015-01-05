# install zarafa-licensed
class zarafa::licensed::install inherits zarafa::common {
  package { 'zarafa-licensed':
    ensure  => $zarafa::params::zarafa_version,
  }
  zarafa::upstart { 'licensed': }
}

