# zarafa webapp serivce (mostly apache2 config)
class zarafa::webapp::service (
  $status = present
) {

  ## mod_php configuration
  #apache2::site {
  #  'zarafa-webapp':
  #    ensure  => $status,
  #    require => Class['zarafa::webapp::config'];
  #  'zarafa-webaccess':
  #    ensure  => $status,
  #    require => Class['zarafa::webapp::config'];
  #  '30-zarafa-ssl':
  #    ensure  => $status,
  #    require => Class['zarafa::webapp::config'];
  #}

  apache2::site { '05-fcgi':
    ensure  => $status,
    require => [
      Class['php5::install::cgi'],
      Class['zarafa::webapp::config']
    ];
  }

  # modules needed for webapp
  apache2::module {
    [ 'ssl', 'headers', 'expires', 'setenvif', 'fcgid', 'deflate' ]:
      ensure => $status,
  }
}

# enable zarafa-webapp service
class zarafa::webapp::service::enabled {
  include apache2::service::enabled
  class { 'zarafa::webapp::service':
    status    => present,
  }
}

# disable zarafa-webapp service
class zarafa::webapp::service::disabled {
  include apache2::service::disabled
  class { 'zarafa::webapp::service':
    status    => absent,
  }
}

