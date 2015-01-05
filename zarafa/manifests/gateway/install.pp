# install zarafa-gateway
class zarafa::gateway::install inherits zarafa::common {
  package { 'zarafa-gateway':
    ensure  => $zarafa::params::zarafa_version,
  }
  package { 'libtcmalloc-minimal0':
    ensure  => present,
  }
  zarafa::upstart { 'gateway': }
}
