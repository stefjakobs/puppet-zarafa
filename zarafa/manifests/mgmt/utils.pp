# install zarafa-utils
# this has its own class because it's needed by zarafa-server, too
class zarafa::mgmt::utils {
  include repos::zarafa

  package { 'zarafa-utils':
    ensure  => present,
    require => Class['repos::zarafa'],
  }

  ## This packages are here, so it is included by mgmt and znode
  package {
    'zarafa-scripts':
      ensure  => latest,
      require => Class['repos::zarafa'];
    'zarafa-bash-completion':
      ensure => present,
      require => Class['repos::zarafa'];
  }
}
