# zarafa-server configuraton files
# make gab configurable
class zarafa::server::config (
  $attachments_mountpoint = '',
  $enable_gab             = 'yes',
) {
  File {
    ensure  => present,
    owner   => $zarafa::params::zarafa_user,
    group   => $zarafa::params::zarafa_group,
    mode    => '0440',
    require => Class['zarafa::server::install'],
  }

  file {
    "${zarafa::params::config_dir}/server.cfg":
      content => template('zarafa/server/server.cfg.erb'),
      require => Class['ssl'],
      notify  => Class['zarafa::server::service'];

    "${zarafa::params::config_dir}/admin.cfg":
      content => template('zarafa/server/admin.cfg.erb');

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/server.cfg.dpkg-dist":
      ensure  => absent;
    '/etc/init.d/zarafa-server.dpkg-new':
      ensure  => absent;

    "${zarafa::params::config_dir}/ldapms.cfg":
      content => template('zarafa/server/ldapms.cfg.erb'),
      notify  => Class['zarafa::server::service'];

    # /var/lib/zarafa/client
    $zarafa::params::client_dir:
      ensure  => directory,
      mode    => '0750';

    # /var/lib/zarafa/attachments
    $zarafa::params::attachments_dir:
      ensure  => directory,
      # Dies verursacht Probleme, wenn viele Dateien und Verzeichnisse
      # unter dem Verzeichnis liegen, was für gewöhnlich der Fall ist.
      # recurse => true,
      # puppet will automatically set +x for directories
      mode    => '0750';

    '/etc/cron.d/zarafa-purge-softdelete':
      owner   => 'root',
      group   => 'root',
      source  => 'puppet:///modules/zarafa/server/zarafa-purge-softdelete.cron';
    '/etc/cron.d/zarafa-trigger-sync':
      owner   => 'root',
      group   => 'root',
      source  => 'puppet:///modules/zarafa/server/zarafa-trigger-sync.cron';
    '/etc/zarafa/monitor-outgoing-queue.cf':
      owner   => 'root',
      group   => 'nagios',
      content => template('zarafa/server/monitor-outgoing-queue.cf.erb');

    # autoupdate logfiles
    $zarafa::params::client_update_log_path:
      ensure  => directory,
      owner   => 'root',
      group   => 'zarafa',
      mode    => '0770';
  }

  ## Mountpoint für Attachments
  if ($zarafa::server::config::attachments_mountpoint) {
    mount { $zarafa::params::attachments_dir:
      ensure    => 'mounted',
      device    => $zarafa::server::config::attachments_mountpoint,
      fstype    => 'nfs',
      options   => 'defaults',
      atboot    => true,
      require   => File[$zarafa::params::attachments_dir],
    }
  }

}

