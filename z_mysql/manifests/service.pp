# mysql service
class z_mysql::service {
  include z_mysql::params

  service { $z_mysql::params::mysql_service_name:
    hasstatus  => true,
    hasrestart => true,
    require    => Class['z_mysql::config'],
    provider   => $z_mysql::params::mysql_service_provider,
  }

  if ($z_mysql::params::mysql_service_provider == 'upstart') {
    file { $z_mysql::params::mysql_rc_files:
      ensure => absent,
    }
  }
}

# mysql service enabled
class z_mysql::service::enabled inherits z_mysql::service {
  Service[$z_mysql::params::mysql_service_name] {
    ensure => running
  }
  if ($z_mysql::params::mysql_service_provider == 'upstart') {
    file { '/etc/init/mysql.override':
      ensure => absent,
    }
  }
}

# mysql service disabled
class z_mysql::service::disabled inherits z_mysql::service {
  Service[$z_mysql::params::mysql_service_name] {
    ensure => stopped
  }
  if ($z_mysql::params::mysql_service_provider == 'upstart') {
    file { '/etc/init/mysql.override':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => 'manual',
    }
  }
}
