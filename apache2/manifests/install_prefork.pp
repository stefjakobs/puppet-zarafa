# install apache2 prefork
class apache2::install_prefork (
  $l_ensure  = present,
) {
  # can not include classes with parameters twice
  if $l_ensure == present {
    include apache2::install
  } else {
    class { 'apache2::install':
      l_ensure => $l_ensure;
    }
  }
  package { 'apache2-mpm-prefork':
    ensure   => $l_ensure,
  }

  package {
    'libapache2-mod-fcgid':
      ensure => purged;
    'apache2-mpm-worker':
      ensure => purged;
    'apache2-mpm-itk':
      ensure => purged;
  }
}
