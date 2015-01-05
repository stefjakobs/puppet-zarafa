# apache configuration for autoconfig and autodiscover
# this can't be placed in a define: Duplicate definition

class autoconfig::config {

  ## create a port based NameVirtualHost configuration
  ## on each ip address and HTTP and HTTPS ports
  class { 'apache2':
    namevirtualhost => [
      "${::ipaddress}:80",
      "${::ipaddress}:443",
      "[${::ipaddress6}]:80",
      "[${::ipaddress6}]:443",
    ],
    service_cert  => $::fqdn,
  }

  apache2::module { [ 'ssl', 'rewrite' ]:
    ensure => present,
  }

  ## disable apache's default configuration
  apache2::site {
    '000-default':
      ensure => absent;
    'default-ssl':
      ensure => absent;
  }
  file {
    '/etc/apache2/sites-enabled/000-default':
      ensure   => absent,
      notify   => Class['apache2::service'];
    '/etc/apache2/sites-enabled/default-ssl':
      ensure   => absent,
      notify   => Class['apache2::service'];
  }

}
