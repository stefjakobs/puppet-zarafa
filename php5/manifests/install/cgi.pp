## install php5 cgi - needed for fcgid
class php5::install::cgi inherits php5::install {
  package {
    'php5-cgi':
      ensure => present;
  }

  file { '/usr/local/bin/php-fcgid-wrapper':
    ensure   => present,
    owner    => 'root',
    group    => 'root',
    mode     => '0755',
    source   => 'puppet:///modules/php5/php-fcgid-wrapper',
  }

  file { '/etc/apache2/sites-available/05-fcgi':
    ensure   => present,
    owner    => 'root',
    group    => 'root',
    mode     => '0444',
    source   => 'puppet:///modules/php5/05-fcgi',
    require  => Class['apache2::config'],
  }

  file { '/etc/apache2/conf.d/php5-fcgi':
    ensure   => present,
    owner    => 'root',
    group    => 'root',
    mode     => '0444',
    source   => 'puppet:///modules/php5/php5-fcgi',
    require  => Class['apache2::config'],
  }
}
