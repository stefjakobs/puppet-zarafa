# zarafa-spooler configuration files
class zarafa::spooler::config {

  File {
    require => Class['zarafa::spooler::install'],
  }

  file {
    "${zarafa::params::config_dir}/spooler.cfg":
      ensure  => present,
      owner   => $zarafa::params::zarafa_user,
      group   => $zarafa::params::zarafa_group,
      mode    => '0440',
      content => template('zarafa/spooler/spooler.cfg.erb'),
      notify  => Class['zarafa::spooler::service'];

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/spooler.cfg.dpkg-dist":
      ensure  => absent;
    '/etc/init.d/zarafa-spooler.dpkg-new':
      ensure  => absent;

    "${zarafa::params::base_dir}/spooler":
      ensure  => directory,
      owner   => $zarafa::params::zarafa_user,
      group   => $zarafa::params::zarafa_group,
      mode    => '0750';
  }
}
