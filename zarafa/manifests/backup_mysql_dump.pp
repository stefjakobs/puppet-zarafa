## Everything that is needed to perform a db dump one one done
class zarafa::backup_mysql_dump (
  $nfs_server_path    = '',
  $backup_destination = '/var/backups/zarafa',
  $notification_rcpt  = '',
  $backup_owner       = 'root',
  $backup_group       = 'root',
) {

  File {
    owner     => $backup_owner,
    group     => $backup_group,
    mode      => '0640',
  }

  file {
    '/etc/cron.d/zarafa-dump-backup':
      ensure  => present,
      mode    => '0644',
      source  => 'puppet:///modules/zarafa/zarafa-dump-backup.cron',
      require => [
        Package['zarafa-scripts'],
        File['/etc/zarafa/zarafa-dump-backup.conf'],
      ];
    '/etc/zarafa/zarafa-dump-backup.conf':
      ensure  => present,
      content => template('zarafa/zarafa-dump-backup.conf.erb'),
      require => User[$zarafa::params::zarafa_user];
    $backup_destination :
      ensure  => directory,
      group   => $zarafa::params::zarafa_group;
  }

  ## Mount nfs volume if set
  if ($nfs_server_path) {
    mount { $backup_destination:
      ensure    => 'mounted',
      device    => $nfs_server_path,
      fstype    => 'nfs',
      options   => 'defaults',
      atboot    => true,
      require   => File[$backup_destination],
    }
  }
}
