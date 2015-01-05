# install webapp with its dependencies
class zarafa::webapp::install inherits zarafa::common {
  include php5::cgi
  include apache2
  include apache2::install_worker

  package { 'zarafa-webaccess':
    ensure  => $zarafa::params::zarafa_version,
  }
  package { 'zarafa-webaccess-muc':
    ensure  => $zarafa::params::zarafa_version,
  }
  package { 'zarafa-webapp':
    ensure  => $zarafa::params::webapp_version,
  }
  package { 'zarafa-contacts':
    ensure  => $zarafa::params::zarafa_version,
  }

}

