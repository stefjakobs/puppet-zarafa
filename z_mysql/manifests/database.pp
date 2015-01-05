# create a database with name equals to the define-name
# grant permissions to a user with password
define z_mysql::database (
  $user,
  $password,
) {

  exec { "create-${name}-db":
    unless  => "/usr/bin/mysql -uroot \
                -p'${z_mysql::params::mysql_root_password}' ${name}",
    command => "/usr/bin/mysql -uroot \
                -p'${z_mysql::params::mysql_root_password}' \
                -e \"create database ${name};\"",
    require => Class['z_mysql::service::enabled', 'z_mysql::prepare'],
  }

  exec { "grant-${name}-db":
    unless  => "/usr/bin/mysql -u${user} -p'${password}' ${name}",
    command => "/usr/bin/mysql -uroot \
                -p'${z_mysql::params::mysql_root_password}' \
                -e \"GRANT alter, create, create routine, alter routine, \
                   delete, drop, index, insert, lock tables, select, \
                   update ON ${name}.* TO ${user}@'localhost' \
                identified by '${password}';\"",
    require => [ Class['z_mysql::service::enabled', 'z_mysql::prepare'],
                 Exec["create-${name}-db"]
               ]
  }
}
