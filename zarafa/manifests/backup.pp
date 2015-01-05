## Everything that is needed to perform a Backup over all nodes
class zarafa::backup (
  $backup_user  = 'zarafa-backup',
  $alias_rcpt   = 'zarafa-admin-i@example.com',
) {

  realize(Users::Account[$backup_user])
  postfix::aliases {
    $backup_user:
      rcpt       => $alias_rcpt;
  }

  file {
    '/etc/cron.d/zarafa-offline-backup':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  => 'puppet:///modules/zarafa/zarafa-offline-backup.cron',
      require => [
        File["/home/${backup_user}/bin/zarafa-offline-backup.sh"],
        File['/etc/zarafa-offline-backup.cfg'],
        User[$backup_user],
      ];
    "/home/${backup_user}/bin/zarafa-offline-backup.sh":
      ensure  => present,
      owner   => $backup_user,
      mode    => '0750',
      source  => 'puppet:///modules/zarafa/zarafa-offline-backup.sh',
      require => User[$backup_user];
    '/etc/zarafa-offline-backup.cfg':
      ensure  => present,
      owner   => $backup_user,
      mode    => '0640',
      source  => 'puppet:///modules/zarafa/zarafa-offline-backup.cfg',
      require => User[$backup_user];
    '/etc/zarafa-offline-backup-QS.cfg':
      ensure  => present,
      owner   => $backup_user,
      mode    => '0640',
      source  => 'puppet:///modules/zarafa/zarafa-offline-backup-QS.cfg',
      require => User[$backup_user];
  }
}
