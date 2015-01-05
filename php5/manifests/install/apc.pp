# install php5-apc module
class php5::install::apc inherits php5::install {
  ## Packages present
  package {
    'php-apc':
      ensure => present;
  }
}

