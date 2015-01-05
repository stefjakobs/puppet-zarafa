# prepare an mysql dB
# does the same as the script 'mysql-secure-install'
class z_mysql::prepare {

  Exec {
    subscribe   => [ Package[$z_mysql::params::mysql_pkg_name],
                     Class['z_mysql::mount']
                   ],
    require     => Class['z_mysql::install', 'z_mysql::service::enabled'],
  }

  exec { 'wait-for-mysqld':
    command     => '/bin/sleep 5 && /usr/bin/test \
                    -S /var/run/mysqld/mysqld.sock',
    require     => Class['z_mysql::service::enabled'],
    refreshonly => true,
  }

  exec { 'set-mysql-password':
    unless      => "mysqladmin -uroot \
                    -p'${z_mysql::params::mysql_root_password}' status",
    path        => [ '/bin', '/usr/bin' ],
    command     => "mysqladmin -uroot \
                    password ${z_mysql::params::mysql_root_password}",
    require     => Exec['wait-for-mysqld'],
    refreshonly => true,
  }

  exec { 'remove-anon-users':
    path        => [ '/bin', '/usr/bin' ],
    command     => "echo \"DELETE FROM mysql.user WHERE User='';\" | \
                    mysql -uroot -p'${z_mysql::params::mysql_root_password}' ",
    require     => Exec['wait-for-mysqld', 'set-mysql-password'],
    refreshonly => true,
  }

  exec { 'remove-remote-root':
    path        => [ '/bin', '/usr/bin' ],
    command     => "echo \"DELETE FROM mysql.user WHERE User='root' AND Host \
                    NOT IN ('localhost', '127.0.0.1', '::1');\" | mysql \
                    -uroot -p'${z_mysql::params::mysql_root_password}' ",
    require     => Exec['wait-for-mysqld', 'set-mysql-password'],
    refreshonly => true,
  }

  exec { 'remove-test-database':
    onlyif      => "mysql -uroot \
                    -p'${z_mysql::params::mysql_root_password}' test",
    path        => [ '/bin', '/usr/bin' ],
    command     => "echo \"DROP DATABASE test; DELETE FROM mysql.db WHERE \
                    Db='test' OR Db='test\\_%';\" | mysql -uroot \
                    -p'${z_mysql::params::mysql_root_password}' ",
    require     => Exec['wait-for-mysqld', 'set-mysql-password'],
    refreshonly => true,
  }

  exec { 'reload-privilege-tables':
    path        => [ '/bin', '/usr/bin' ],
    command     => "mysqladmin -uroot \
                    -p'${z_mysql::params::mysql_root_password}' \
                    flush-privileges",
    require     => Exec['wait-for-mysqld',
                        'remove-test-database',
                        'remove-remote-root',
                        'remove-anon-users'
                      ],
    refreshonly => true,
  }

  file { '/root/.my.cnf':
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('z_mysql/root.my.cnf.erb'),
    require => Exec['set-mysql-password'],
  }

}
