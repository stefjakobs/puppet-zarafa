# install apache2 - but don't decide wheter it's prefork or worker
class apache2::install (
  $l_ensure = present,
) {
  package {
    'apache2':
      ensure => $l_ensure;
    'apache2.2-common':
      ensure => $l_ensure;
    'apache2.2-bin':
      ensure => $l_ensure;
    'apache2-utils':
      ensure => $l_ensure;
  }
}
