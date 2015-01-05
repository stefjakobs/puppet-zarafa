# install zarafa-dagent
class zarafa::dagent::install inherits zarafa::common {

  package { 'zarafa-dagent':
    ensure  => $zarafa::params::zarafa_version,
  }
  zarafa::upstart { 'dagent': }

  ## disable apache purge because of zarafa-sabre
  #package {
  #  'apache2-mpm-prefork':
  #    ensure => purged;
  #  'apache2-utils':
  #    ensure => purged;
  #  'apache2.2-bin':
  #    ensure => purged;
  #  'libapache2-mod-php5':
  #    ensure => purged;
  #  'php5-fpm':
  #    ensure => purged;
  #  'libapr1':
  #    ensure => purged;
  #  'libaprutil1':
  #    ensure => purged;
  #  'libaprutil1-dbd-sqlite3':
  #    ensure => purged;
  #  'libaprutil1-ldap':
  #    ensure => purged;
  #}
}
