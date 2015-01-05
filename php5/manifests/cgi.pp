# everything that is needed to have a apache2 with fastcgi working
class php5::cgi inherits php5 {
  include php5::install::cgi

  file { '/etc/php5/cgi/php.ini':
    ensure   => present,
    owner    => root,
    group    => root,
    mode     => '0644',
    content  => template('php5/php.ini.erb'),
    require  => Class['php5::install'],
  }
}
