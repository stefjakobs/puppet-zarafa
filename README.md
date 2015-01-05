puppet-zarafa
=============

Zarafa Puppet Modules

A sample configuration could look like:

Examples:
=========

## super class which should be included by all zarafa nodes
class base {
  include zarafa::params
}

## super class which should be included by all zarafa-server nodes
class base::znode (
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
  $_env = capitalize($environment)

  class { 'zarafa::node':
    ldap_bind_user              => $base::znode::ldap_bind_user,
    ldap_bind_passwd            => $base::znode::ldap_bind_passwd,
    ldap_search_base            => $base::znode::ldap_search_base,
    ldap_primary_server         => $base::znode::ldap_primary_server,
    ldap_backup_servers         => $base::znode::ldap_backup_servers,
    attachments_mountpoint      => $base::znode::attachments_mountpoint,
    index_mountpoint            => $base::znode::index_mountpoint,
    backup_mountpoint           => $base::znode::backup_mountpoint,
    enable_gab                  => $base::znode::enable_gab,
    threads                     => $base::znode::threads,
    cache_cell_size             => $base::znode::cache_cell_size,
    cache_object_size           => $base::znode::cache_object_size,
    cache_indexedobject_size    => $base::znode::cache_indexedobject_size,
    cache_userdetails_size      => $base::znode::cache_userdetails_size,
    quota_warn                  => $base::znode::quota_warn,
    quota_soft                  => $base::znode::quota_soft,
    quota_hard                  => $base::znode::quota_hard,
    companyquota_warn           => $base::znode::companyquota_warn,
    user_safe_mode              => $base::znode::user_safe_mode,
    innodb_buffer_pool_size     => $base::znode::innodb_buffer_pool_size,
    innodb_data_file_path       => $base::znode::innodb_data_file_path,
    innodb_autoextend_increment => $base::znode::innodb_autoextend_increment,
    innodb_log_file_size        => $base::znode::innodb_log_file_size,
    mysql_device                => $base::znode::mysql_device,
    mysql_fstype                => $base::znode::mysql_fstype,
  }

  file {
    '/usr/local/sbin/zarafa-report-orphan-stores.sh':
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      source  => 'puppet:///modules/zarafa/zarafa-report-orphan-stores.sh';
    '/etc/cron.d/zarafa-report-orphan-stores':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => '35 8 * * *  root  /usr/local/sbin/zarafa-report-orphan-stores.sh -R -d';
  }

}

## super class which should be included by all webapp-server nodes
class base::zwebapp (
  $z_push_nfs_host = ''
) {
  include base
  $_env = capitalize($environment)
  include zarafa::webapp
  class { 'z_push':
    nfs_host => $base::zwebapp::z_push_nfs_host
  }
    apache2::site {
    '000-default':
      ensure => absent;
    'default-ssl':
      ensure => absent;
  }
  file {
    '/etc/apache2/sites-enabled/000-default':
      ensure   => absent,
      notify   => Class['apache2::service'];
    '/etc/apache2/sites-enabled/default-ssl':
      ensure   => absent,
      notify   => Class['apache2::service'];
  }

  # needed for socket proxy
  apache2::module {
    [ 'proxy', 'proxy_balancer', 'proxy_http' ]:
      ensure => present;
    [ 'authz_default', 'authz_groupfile', 'authz_user',
      'cgid', 'reqtimeout', 'auth_basic', 'authn_file',
      'autoindex', 'fastcgi', 'env', 'negotiation',
    ]:
      ensure => absent;
  }
}

## super class which should be included by all gateway-server nodes
class base::zgateway {
  include base
  $_env = capitalize($environment)
  include zarafa::ical
  class { 'zarafa::gateway':
     imaps_enable => 'yes',
     imaps_port   => '8993',
  }
  class { 'stunnel':
    max_open_files => '10000',
  }
  
}

## Example node definitions

node 'node1.local' {
  class { 'base::znode':
    ldap_bind_user              => "CN=.....",
    ldap_bind_passwd            => 'secret',
    ldap_search_base            => 'dc=example,dc=org',
    ldap_primary_server         => 'ldaps://ldap1.example.org:3269',
    ldap_backup_servers         => 'ldaps://ldap2.example.org:3269',
    attachments_mountpoint      =>
      'zarafa-nfs-dev.example.org:/vol/zarafa_attach_dev/node1',
    index_mountpoint            => '',
    enable_gab                  => 'no',
    threads                     => '4',
    cache_cell_size             => '500M',
    cache_object_size           => '50M',
    cache_indexedobject_size    => '16M',
    cache_userdetails_size      => '5M',
    quota_warn                  => '90M',
    quota_soft                  => '95M',
    quota_hard                  => '100M',
    user_safe_mode              => 'no',
    innodb_buffer_pool_size     => '800M',
    innodb_data_file_path       => 'ibdata1:50M:autoextend',
    innodb_autoextend_increment => '1000',
    innodb_log_file_size        => '10M',
    mysql_device                => '/dev/sdc1',
  }
  class { 'zarafa::monitor':
    quota_check_interval     => '15',
  }
  class { 'zarafa::gateway':
    server_bind     => '127.0.0.1',
    server_socket   => 'file:///var/run/zarafa',
    server_hostname => 'zarafa gateway testing',
    imaps_enable    => 'yes',
  }
  #include zarafa::gateway::purged
  class { 'zarafa::ical':
    server_bind     => '127.0.0.1',
    server_socket   => 'file:///var/run/zarafa',
    icals_enable    => 'no',
  }
  #include zarafa::ical::purged

  include zarafa::sabre
  #include zarafa::sabre::purged
}

node 'webapp1.local' {
  class { 'base::zgateway':
    include_munin   => false
  }

  class { 'base::zwebapp':
    z_push_nfs_host => 'zarafa-nfs-dev.example.org:/vol/zarafa_dev'
  }

  apache2::vhost { 'zarafa-socket-proxy':
    servername    => 'node1.example.org',
    serveraliases => 'webapp1.example.org',
    port          => 237,
    ssl           => true,
    listen        => true,
    priority      => 10,
    template      => 'apache2/zarafa-socket-proxy.erb',
    # Erster Proxy muss multi homed sein
    proxylist     => [
      'node.example.org',
      'node1.example.org',
      'node2.example.org',
    ],
  }

  apache2::vhost { 'zarafa-no-ssl':
    servername    => 'webapp1.example.org',
    port          => 80,
    priority      => 20,
    docroot       => '/var/www/default/',
    serveradmin   => 'postmaster@example.org',
  }

  apache2::vhost { 'zarafa-ssl':
    servername    => 'node1.example.org',
    serveraliases => [
      'webapp1.example.org',
      'mail.example.org',
    ],
    port          => 443,
    priority      => 30,
    serveradmin   => 'postmaster@example.org',
    template      => 'apache2/zarafa-www-proxy-ssl.erb',
    proxylist     => [
      'webapp1.example.org',
      'webapp2.example.org',
    ],
  }

  apache2::redirect { 'zarafa-redirect':
    source        => '^/$',
    destination   => 'https://mail.example.org/webapp/',
  }
}

node 'mail-gateway.local' {
  include base::zgateway
}
