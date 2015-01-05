# zarafa-utils configuration files
class zarafa::mgmt::config {
  File {
    owner    => 'root',
    group    => 'root',
    mode     => '0440',
    require  => Class['zarafa::mgmt::install'],
  }

  file {
    "${zarafa::params::config_dir}/backup.cfg":
      ensure   => present,
      content  => template('zarafa/mgmt/backup.cfg.erb');

    "${zarafa::params::config_dir}/admin.cfg":
      ensure   => present,
      content  => template('zarafa/mgmt/admin.cfg.erb');

    "${zarafa::params::config_dir}/msr.cfg":
      ensure   => present,
      content  => template('zarafa/mgmt/msr.cfg.erb');
  }
}
