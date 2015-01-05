# install zarafa-search
class zarafa::search::install inherits zarafa::common {

  package { 'zarafa-search':
    ensure  => $zarafa::params::zarafa_version,
  }
  zarafa::upstart { 'search': }
}
