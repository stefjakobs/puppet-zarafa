# everything that is needed to have a working mysql service
class z_mysql (
  $max_allowed_packet               = '32M',
  $thread_stack                     = '512K',
  $thread_cache_size                = '8',
  $max_connections                  = '100',
  $max_connect_errors               = '10',
  $thread_concurrency               = $::processorcount,
  $table_cache                      = '500',
  $key_buffer_size                  = '32M',
  $bulk_insert_buffer_size          = '64M',
  $query_cache_size                 = '64M',
  $query_cache_limit                = '2M',
  $innodb_buffer_pool_size          = '1G',
  $innodb_data_file_path            = 'ibdata1:1G:autoextend',
  $innodb_autoextend_increment      = '100',
  $innodb_write_io_threads          = $::processorcount,
  $innodb_read_io_threads           = $::processorcount,
  $innodb_flush_log_at_trx_commit   = '1',
  $innodb_log_buffer_size           = '32M',
  $innodb_log_file_size             = '100M',
  $innodb_log_files_in_group        = '3',
  $innodb_lock_wait_timeout         = '120',
  $device                           = '',
  $fstype                           = 'ext4',
) {
  class { 'z_mysql::install':
    device => $z_mysql::device,
    fstype => $z_mysql::fstype,
  }
  include z_mysql::config, z_mysql::params, z_mysql::prepare
  include z_mysql::service::enabled
}
