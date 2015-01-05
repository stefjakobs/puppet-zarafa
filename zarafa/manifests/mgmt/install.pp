# install other zarafa-utils
class zarafa::mgmt::install {
  include zarafa::mgmt::utils

  package { 'zarafa-backup':
    ensure  => $zarafa::params::zarafa_version,
    require => Class['repos::zarafa'],
  }
  package { 'python-mapi':
    ensure  => $zarafa::params::zarafa_version,
    require => Class['repos::zarafa'],
  }
}
