# everything that is needed to have php5 with mapi extension working
class php5::mapi inherits php5 {
  include php5::install::mapi

  file { '/etc/php5/cli/conf.d/zarafa.ini':
    ensure   => link,
    target   => '/etc/php5/apache2/conf.d/zarafa.ini',
    require  => Class['php5::install::mapi'],
  }

}
