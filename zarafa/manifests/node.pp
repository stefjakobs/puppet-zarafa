# install zarafa-server and enable service
class zarafa::node (
  $ldap_bind_user,
  $ldap_bind_passwd,
  $ldap_search_base,
  $ldap_primary_server,
  $ldap_backup_servers         = '',
  $attachments_mountpoint      = '',
  $index_mountpoint            = '',
  $backup_mountpoint           = '',
  $enable_gab                  = 'yes',
  $threads                     = '8',
  $cache_cell_size             = '8G',
  $cache_object_size           = '5M',
  $cache_indexedobject_size    = '16M',
  $cache_userdetails_size      = '25M',
  $quota_warn                  = '0',
  $quota_soft                  = '0',
  $quota_hard                  = '0',
  $companyquota_warn           = '0',
  $user_safe_mode              = 'no',
  $innodb_buffer_pool_size     = '10G',
  $innodb_data_file_path       = 'ibdata1:100G:autoextend',
  $innodb_autoextend_increment = '1000',
  $innodb_log_file_size        = '100M',
  $mysql_device                = '',
  $mysql_fstype                = 'ext4',
) {
  include zarafa::params

  file { $zarafa::params::base_dir:
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
  }

  class { 'zarafa::server::install':
    innodb_buffer_pool_size     => $zarafa::node::innodb_buffer_pool_size,
    innodb_data_file_path       => $zarafa::node::innodb_data_file_path,
    innodb_autoextend_increment => $zarafa::node::innodb_autoextend_increment,
    innodb_log_file_size        => $zarafa::node::innodb_log_file_size,

    mysql_device                => $zarafa::node::mysql_device,
    mysql_fstype                => $zarafa::node::mysql_fstype,
  }
  class { 'zarafa::server::config':
    attachments_mountpoint => $zarafa::node::attachments_mountpoint,
    enable_gab             => $zarafa::node::enable_gab,
  }
  include zarafa::server::service::enabled

  # Jede Multi-Server-Instanz benötigt einen eigenen Search-Daemon!!!
  include zarafa::search::install
  class { 'zarafa::search::config':
    index_mountpoint => $zarafa::node::index_mountpoint,
  }
  include zarafa::search::service::enabled

  # Jede Multi-Server-Instanz benötigt einen eigenen license-Daemon!!!
  include zarafa::licensed::install, zarafa::licensed::config
  include zarafa::licensed::service::enabled

  # Jede Multi-Server-Instanz benötigt einen eigenen spooler-Daemon!!!
  include zarafa::spooler::install, zarafa::spooler::config
  include zarafa::spooler::service::enabled

  # Jede Multi-Server-Instanz benötigt einen eigenen dAgent-Daemon!!!
  include zarafa::dagent::install, zarafa::dagent::config
  include zarafa::dagent::service::enabled

  # Jede Node soll einen Backup via mysql dump ausführen
  class { 'zarafa::backup_mysql_dump':
    nfs_server_path  => $zarafa::node::backup_mountpoint,
  }
}
