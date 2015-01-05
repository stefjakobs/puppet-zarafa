# install zarafa-server
class zarafa::server::install (
  $innodb_buffer_pool_size     = '10G',
  $innodb_data_file_path       = 'ibdata1:100G:autoextend',
  $innodb_autoextend_increment = '1000',
  $innodb_log_file_size        = '100M',
  $mysql_device                = '',
  $mysql_fstype                = 'ext4',
) inherits zarafa::common {

  class { 'zarafa::server::mysql_db':
    innodb_buffer_pool_size     => $zarafa::server::install::innodb_buffer_pool_size,
    innodb_data_file_path       => $zarafa::server::install::innodb_data_file_path,
    innodb_autoextend_increment => $zarafa::server::install::innodb_autoextend_increment,
    innodb_log_file_size        => $zarafa::server::install::innodb_log_file_size,
    mysql_device                => $zarafa::server::install::mysql_device,
    mysql_fstype                => $zarafa::server::install::mysql_fstype,
  }
  include zarafa::mgmt::utils

  package {
    'zarafa-server':
      ensure  => $zarafa::params::zarafa_version,
      require => [ Package['zarafa-utils'],
                   Package['zarafa-multiserver'],
                 ];
    'zarafa-multiserver':
      ensure  => $zarafa::params::zarafa_version;
    'zarafa-outlook-client':
      ensure  => $zarafa::params::client_version,
      require => Package['zarafa-server'];
  }
  zarafa::upstart { 'server': }

}
