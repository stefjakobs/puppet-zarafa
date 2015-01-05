# apache2 service
class apache2::service {
  service { 'apache2':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['apache2::install'],
  }
}

# apache2 service enabled
class apache2::service::enabled inherits apache2::service {
  Service['apache2'] { ensure => running, enable => true, }
}

# apache2 service disabled
class apache2::service::disabled inherits apache2::service {
  Service['apache2'] { ensure => stopped, enable => false, }
}
