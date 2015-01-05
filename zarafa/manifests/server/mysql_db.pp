# install mysql and create database with user and passwort
class zarafa::server::mysql_db (
  $innodb_buffer_pool_size     = '10G',
  $innodb_data_file_path       = 'ibdata1:100G:autoextend',
  $innodb_autoextend_increment = '1000',
  $innodb_log_file_size        = '100M',
  $mysql_device                = '',
  $mysql_fstype                = 'ext4',
) {

  if ! ($zarafa::server::mysql_db::mysql_device) {
    fail("Modul ${module_name}: No MySQL Device named.")
  }

  class { 'z_mysql':
    innodb_buffer_pool_size     => $zarafa::server::mysql_db::innodb_buffer_pool_size,
    innodb_data_file_path       => $zarafa::server::mysql_db::innodb_data_file_path,
    innodb_autoextend_increment => $zarafa::server::mysql_db::innodb_autoextend_increment,
    innodb_log_file_size        => $zarafa::server::mysql_db::innodb_log_file_size,
    device                      => $zarafa::server::mysql_db::mysql_device,
    fstype                      => $zarafa::server::mysql_db::mysql_fstype,
  }
  z_mysql::database { $zarafa::params::mysql_database:
    user     => $zarafa::params::mysql_zarafa_user,
    password => $zarafa::params::mysql_zarafa_password,
  }

}
