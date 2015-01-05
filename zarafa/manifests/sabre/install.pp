# install zarafa-sabre
class zarafa::sabre::install {
  include zarafa::sabre::params
  class { 'apache2::install_prefork':
    l_ensure => present,
  }
  class { 'php5::install::mod_php5':
    l_ensure => present,
  }
  class { 'php5::install::mapi':
    l_ensure => present,
  }

  package { 'zarafa-sabre':
    ensure   => present,
    require  => [
      Class['apache2::install_prefork'],
      Class['php5::install::mapi'],
      Class['php5::install::mod_php5'],
      Class['repos::zarafa'],
    ],
    notify   => Class['apache2::service'],
  }

  package {
    'libparse-recdescent-perl':
      ensure  => present;
    'libencode-imaputf7-perl':
      ensure  => present;
    'imapsync':
      ensure  => present;
    'bsd-mailx':
      ensure  => purged;
    'heirloom-mailx':
       ensure => present;
    'dos2unix':
      ensure  => present;
  }

  package {
    'python-zarafa':
      ensure  => present,
      require => Class['repos::zarafa'];
    'python-ply':
      ensure  => present;
  }


  File {
    ensure    => present,
    owner     => root,
    group     => root,
    mode      => '0755',
  }

  file {
    '/etc/zarafa/cgp-migrate.conf.example':
      mode    => '0644',
      content => template('zarafa/sabre/cgp-migrate.conf.erb');
    '/usr/local/zarafa-communigate/':
      ensure  => directory;
    '/usr/local/zarafa-communigate/cgp-migrate.sh':
      require => File['/usr/local/zarafa-communigate/'],
      source  => 'puppet:///modules/zarafa/sabre/cgp-migrate.sh';
    '/usr/local/zarafa-communigate/cgp-cleanup.sh':
      require => File['/usr/local/zarafa-communigate/'],
      source  => 'puppet:///modules/zarafa/sabre/cgp-cleanup.sh';
    '/usr/local/zarafa-communigate/cgp.rules':
      ensure  => absent;
      #mode    => '0644',
      #require => File['/usr/local/zarafa-communigate/'],
      #source  => 'puppet:///modules/zarafa/sabre/cgp.rules';
    '/usr/local/zarafa-communigate/cgp-attribute-strip.txt':
      mode    => '0644',
      require => File['/usr/local/zarafa-communigate/'],
      source  => 'puppet:///modules/zarafa/sabre/cgp-attribute-strip.txt';
    '/usr/local/zarafa-communigate/cgp-rules-extract.pl':
      ensure  => absent;
      #require => File['/usr/local/zarafa-communigate/'],
      #source  => 'puppet:///modules/zarafa/sabre/cgp-rules-extract.pl';
    '/usr/local/zarafa-communigate/get-folder-name.py':
      require => File['/usr/local/zarafa-communigate/'],
      source  => 'puppet:///modules/zarafa/sabre/get-folder-name.py';
    '/usr/local/zarafa-communigate/create-folder.py':
      require => File['/usr/local/zarafa-communigate/'],
      source  => 'puppet:///modules/zarafa/sabre/create-folder.py';
    '/usr/local/zarafa-communigate/import-mbox.py':
      require => File['/usr/local/zarafa-communigate/'],
      source  => 'puppet:///modules/zarafa/sabre/import-mbox.py';
    '/usr/local/zarafa-communigate/list-folder-size.py':
      require => File['/usr/local/zarafa-communigate/'],
      source  => 'puppet:///modules/zarafa/sabre/list-folder-size.py';
    '/usr/local/zarafa-communigate/zarafa-remove-store.sh':
      require => File['/usr/local/zarafa-communigate/'],
      source  => 'puppet:///modules/zarafa/sabre/zarafa-remove-store.sh';

    '/usr/local/zarafa-communigate/cgon.py':
      require => File['/usr/local/zarafa-communigate/'],
      source  => 'puppet:///modules/zarafa/sabre/cgon.py';
    '/usr/local/zarafa-communigate/convert_rules.py':
      require => File['/usr/local/zarafa-communigate/'],
      source  => 'puppet:///modules/zarafa/sabre/convert_rules.py';
  }

  apache2::module { 'rewrite':
    ensure => present,
  }
}
