# install mysql
class z_mysql::install (
    $device = '',
    $fstype = 'ext4',
) {
  include z_mysql::params
  class { 'z_mysql::mount':
    device => $z_mysql::install::device,
    fstype => $z_mysql::install::fstype,
  }

  Package {
    require => Class['z_mysql::config'],
  }

  if ( $z_mysql::install::device ) {
    package { $z_mysql::params::mysql_pkg_name:
      ensure  => installed,
      require => Mount[$z_mysql::params::mysql_mountpoint],
    }
  } else {
    package { $z_mysql::params::mysql_pkg_name:
      ensure  => installed,
    }
  }
  package { 'mysql-client':
    ensure  => installed,
  }

}
