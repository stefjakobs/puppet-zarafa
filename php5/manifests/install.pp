# install php5
class php5::install {
  package {
    'php5-common':
      ensure => present;
    'php5-cli':
      ensure => present;
    'php-config':
      ensure => present;
  }

  ## Packages purged
  package {
    'php5-fpm':
      ensure => purged;
    'libapache2-mod-php5':
      ensure => purged;
  }
}
