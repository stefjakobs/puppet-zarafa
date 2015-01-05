# z-push configuration files
class z_push::config {

  include z_push::params

  File {
    ensure   => present,
    owner    => 'root',
    group    => 'root',
    mode     => '0444',
    require  => Class['z_push::install'],
    notify   => Class['apache2::service'],
  }

  file {
    '/var/www/z-push/.htaccess':
      ensure   => absent;
    '/etc/zarafa/z-push.config.php':
      owner    => 'www-data',
      group    => 'zarafa',
      mode     => '0440',
      content  => template('z_push/config.php.erb');
    '/var/www/z-push/backend/zarafa/config.php':
      content  => template('z_push/backend.zarafa.config.php.erb');

    '/etc/apache2/conf.d/z-push':
      source   => 'puppet:///modules/z_push/z-push.apache';
  }
  # cleanup to silence puppet
  file {
    '/etc/zarafa/z-push.config.php.dpkg-dist':
      ensure   => absent;
  }

  # We need to rewrite login information as we do not use mod_php
  apache2::module { 'rewrite':
    ensure => present,
  }
}
