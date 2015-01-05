# mysql configuration parameters
class z_mysql::params {

  case $environment {
    'testing': {
      $mysql_root_password = 'secret'
      $mysql_mountpoint    = '/var/lib/mysql'
      $mysql_datadir       = "${mysql_mountpoint}/db"
      $mysql_owner         = 'mysql'
      $mysql_group         = 'mysql'
      $mysql_dir_mode      = '0700'
    }
    'staging': {
      $mysql_root_password = 'secret'
      $mysql_mountpoint    = '/var/lib/mysql'
      $mysql_datadir       = "${mysql_mountpoint}/db"
      $mysql_owner         = 'mysql'
      $mysql_group         = 'mysql'
      $mysql_dir_mode      = '0700'
    }
    'production': {
      $mysql_root_password = 'secret'
      $mysql_mountpoint    = '/var/lib/mysql'
      $mysql_datadir       = "${mysql_mountpoint}/db"
      $mysql_owner         = 'mysql'
      $mysql_group         = 'mysql'
      $mysql_dir_mode      = '0700'
    }
    default: {
      fail("Module ${module_name} is not supported in env ${::environment}")
    }
  }

  case $::operatingsystem {
    /(opensuse|SLES)/: {
      $mysql_service_name     = 'mysql'
      $mysql_pkg_name         = 'mysql-server'
      $mysql_my_cnf           = '/etc/my.cnf'
      $mysql_service_provider = undef
      $mysql_rc_files         = ''
    }
    /(Ubuntu|Debian)/: {
      $mysql_service_name     = 'mysql'
      $mysql_pkg_name         = 'mysql-server'
      $mysql_my_cnf           = '/etc/mysql/my.cnf'
      $mysql_service_provider = 'upstart'
      $mysql_rc_files         = [
        '/etc/rc0.d/S20mysql', '/etc/rc0.d/K20mysql',
        '/etc/rc1.d/S20mysql', '/etc/rc1.d/K20mysql',
        '/etc/rc2.d/S20mysql', '/etc/rc2.d/K20mysql',
        '/etc/rc3.d/S20mysql', '/etc/rc3.d/K20mysql',
        '/etc/rc4.d/S20mysql', '/etc/rc4.d/K20mysql',
        '/etc/rc5.d/S20mysql', '/etc/rc5.d/K20mysql',
        '/etc/rc6.d/S20mysql', '/etc/rc6.d/K20mysql'
      ]
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
