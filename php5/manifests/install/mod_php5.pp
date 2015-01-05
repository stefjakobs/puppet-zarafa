# install apache2 php5 module
class php5::install::mod_php5 (
  $l_ensure = present,
) inherits php5::install {
  ## Packages present
  package {
    'php5':
      ensure => $l_ensure;
  }
  ## Override Attributes
  Package['libapache2-mod-php5'] {
    ensure => $l_ensure,
  }
}

