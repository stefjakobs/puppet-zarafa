# install zarafa-spooler
class zarafa::spooler::install inherits zarafa::common {

  package { 'zarafa-spooler':
    ensure  => $zarafa::params::zarafa_version,
  }
  zarafa::upstart { 'spooler': }
}
