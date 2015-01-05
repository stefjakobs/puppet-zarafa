# zarafa-search configuraton files
class zarafa::search::config (
  $index_mountpoint = ''
) {

  File {
    require => Class['zarafa::search::install'],
  }

  file {
    "${zarafa::params::config_dir}/search.cfg":
      ensure  => present,
      owner   => $zarafa::params::zarafa_user,
      group   => $zarafa::params::zarafa_group,
      mode    => '0440',
      content => template('zarafa/search/search.cfg.erb'),
      notify  => Class['zarafa::search::service'];

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/search.cfg.dpkg-dist":
      ensure  => absent;
    '/etc/init.d/zarafa-search.dpkg-new':
      ensure  => absent;

    "${zarafa::params::base_dir}/index":
      ensure  => directory,
      ## Funktioniert nicht, da dieses Verzeichnis .snapshot beinhaltet
      #recurse => true,
      owner   => $zarafa::params::zarafa_user,
      group   => $zarafa::params::zarafa_group,
      mode    => '0644',
  }

  ## Mountpoint für Index
  if ($zarafa::search::config::index_mountpoint) {
    mount { "${zarafa::params::base_dir}/index":
      ensure    => 'mounted',
      device    => $zarafa::search::config::index_mountpoint,
      fstype    => 'nfs',
      options   => 'defaults',
      atboot    => true,
      require   => File["${zarafa::params::base_dir}/index"],
    }
  }
}
