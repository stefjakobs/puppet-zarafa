# mysql configuration files
class z_mysql::config {
  include z_mysql::params

  file { '/etc/mysql/':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file {
    $z_mysql::params::mysql_my_cnf:
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('z_mysql/my.cnf.erb'),
      #notify  => Class['z_mysql::service'],
      require => File['/etc/mysql/'];

    ## cleanup to prevent puppet warnings
    "${z_mysql::params::mysql_my_cnf}.dpkg-dist":
      ensure  => absent;
  }

}
