# zarafa-licensed configuration files
class zarafa::licensed::config {
  File {
    owner       => $zarafa::params::zarafa_user,
    group       => $zarafa::params::zarafa_group,
    require     => Class['zarafa::licensed::install'],
    notify      => Class['zarafa::licensed::service'],
  }

  file {
    "${zarafa::params::config_dir}/licensed.cfg":
      ensure   => present,
      content  => template('zarafa/licensed/licensed.cfg.erb');

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/licensed.cfg.dpkg-dist":
      ensure  => absent;
    '/etc/init.d/zarafa-licensed.dpkg-new':
      ensure  => absent;

    "${zarafa::params::config_dir}/license":
      ensure   => directory;

    "${zarafa::params::config_dir}/license/base":
      ensure   => present,
      source   => 'puppet:///modules/zarafa/licensed/base',
      require  => File["${zarafa::params::config_dir}/license"];

    "${zarafa::params::config_dir}/license/1":
      ensure   => present,
      content  => 'ZK6PL4T4E831Q2Q3H',
      require  => File["${zarafa::params::config_dir}/license"];

    "${zarafa::params::base_dir}/report":
      ensure   => directory,
      owner    => $zarafa::params::zarafa_user,
      group    => $zarafa::params::zarafa_group,
      mode     => '0750';
  }
}
