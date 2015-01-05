# php5 configuration files
class php5::config {
  include php5::params

  file { '/etc/php5/apache2/php.ini':
    ensure   => present,
    owner    => root,
    group    => root,
    mode     => '0644',
    content  => template('php5/php.ini.erb'),
    require  => Class['php5::install'],
  }

  file { '/etc/php5/cli/php.ini':
    ensure   => present,
    owner    => root,
    group    => root,
    mode     => '0644',
    content  => template('php5/php.ini.erb'),
    require  => Class['php5::install'],
  }
}
