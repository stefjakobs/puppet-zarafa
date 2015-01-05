# zarafa-dagent configuraton files
class zarafa::dagent::config (
  $autorespond_timelimit_days = '7',
  $autorespond_senddb         = "${zarafa::params::base_dir}/dagent/senddb"
) {

  File {
    require => Class['zarafa::dagent::install'],
  }

  file {
    "${zarafa::params::config_dir}/autorespond":
      ensure  => present,
      owner   => $zarafa::params::zarafa_user,
      group   => $zarafa::params::zarafa_group,
      mode    => '0440',
      content => template('zarafa/dagent/autorespond.erb'),
      notify  => Class['zarafa::dagent::service'];

    "${zarafa::params::config_dir}/dagent.cfg":
      ensure  => present,
      owner   => $zarafa::params::zarafa_user,
      group   => $zarafa::params::zarafa_group,
      mode    => '0440',
      content => template('zarafa/dagent/dagent.cfg.erb'),
      notify  => Class['zarafa::dagent::service'];

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/dagent.cfg.dpkg-dist":
      ensure  => absent;
    "${zarafa::params::config_dir}/autorespond.dpkg-dist":
      ensure  => absent;
    '/etc/init.d/zarafa-dagent.dpkg-new':
      ensure  => absent;

    "${zarafa::params::base_dir}/dagent":
      ensure  => directory,
      recurse => true,
      purge   => true,
      owner   => $zarafa::params::zarafa_user,
      group   => $zarafa::params::zarafa_group,
      mode    => '0750';

    "${zarafa::params::base_dir}/dagent/plugins":
      ensure  => directory,
      owner   => $zarafa::params::zarafa_user,
      group   => $zarafa::params::zarafa_group,
      mode    => '0750';

    $autorespond_senddb:
      ensure  => directory,
      owner   => $zarafa::params::zarafa_user,
      group   => $zarafa::params::zarafa_group,
      mode    => '0750';
  }

  ## clean senddb via cronjob
  file {
    '/etc/cron.d/zarafa-clean-senddb':
      ensure  => present,
      mode    => '0644',
      content => template('zarafa/dagent/zarafa-clean-senddb.cron.erb');
  }

}
