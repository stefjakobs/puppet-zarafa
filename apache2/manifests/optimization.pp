## Install zarafa global optimizations
class apache2::optimization {
  # Default Einstellungen festlegen.
  File {
    ensure   => present,
    owner    => $apache2::params::apache2_owner,
    group    => $apache2::params::apache2_group,
    mode     => '0644',
    require  => Class['apache2::install'],
    notify   => Class['apache2::service'],
  }

  file { '/etc/apache2/conf.d/general-optimization':
    source    => 'puppet:///modules/apache2/general-optimization.fcgi',
  }
}
