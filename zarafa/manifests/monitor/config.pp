# zarafa-monitor configuraton files
class zarafa::monitor::config {

  file {
    "${zarafa::params::config_dir}/monitor.cfg":
      ensure   => present,
      owner    => $zarafa::params::zarafa_user,
      group    => $zarafa::params::zarafa_group,
      mode     => '0440',
      content  => template('zarafa/monitor/monitor.cfg.erb'),
      require  => Class['zarafa::monitor::install'],
      notify   => Class['zarafa::monitor::service'];

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/monitor.cfg.dpkg-dist":
      ensure  => absent;
    '/etc/init.d/zarafa-monitor.dpkg-new':
      ensure  => absent;
  }
}
