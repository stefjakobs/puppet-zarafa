# files needed by every zarafa service
class zarafa::common {
  include repos::zarafa
  include zarafa::params
  include openldap

  class { 'ssl':
    ca_file => $zarafa::params::ssl_ca_file,
    ca_path => $zarafa::params::ssl_dir,
    owner   => $zarafa::params::zarafa_user,
    group   => $zarafa::params::zarafa_group,
  }

  Package {
    require => Class['repos::zarafa'],
  }

  package {
    'zarafa-client':
      ensure  => $zarafa::params::zarafa_version;
    'zarafa-libs':
      ensure  => $zarafa::params::zarafa_version;
  }

  File {
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
  }

  file {
    $zarafa::params::zarafa_default_path:
      source  => "puppet:///modules/zarafa/${zarafa::params::zarafa_default_src}";
    # Delete backup file to prevent nagios warnings
    "${zarafa::params::zarafa_default_path}.dpkg-dist":
      ensure  => absent;
    $zarafa::params::config_dir:
      ensure  => directory,
      group   => $zarafa::params::zarafa_group,
      mode    => '0750';
    '/etc/logrotate.d/zarafa':
      source  => 'puppet:///modules/zarafa/zarafa.common.logrotate';
    '/etc/logrotate.d/zarafa.dpkg-dist':
      ensure  => absent;
  }


  user { $zarafa::params::zarafa_user:
    ensure  => present,
    comment => 'zarafa daemons',
    gid     => $zarafa::params::zarafa_group,
    home    => '/var/lib/zarafa',
    shell   => '/bin/false',
    system  => true,
    require => Group[$zarafa::params::zarafa_group],
  }

  postfix::aliases { $zarafa::params::zarafa_user:
      rcpt  => 'root';
  }

  group { $zarafa::params::zarafa_group:
    ensure  => present,
    system  => true,
  }
}
