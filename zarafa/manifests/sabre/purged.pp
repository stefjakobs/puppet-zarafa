# uninstall zarafa-sabre
class zarafa::sabre::purged {
  include zarafa::sabre::params
  class {
    'apache2::install_prefork':
      l_ensure => purged;
    #'apache2::install':
    #  l_ensure => purged;
  }
  class { 'php5::install::mod_php5':
    l_ensure   => purged,
  }

  package { 'zarafa-sabre':
    ensure   => purged,
  }

  package {
    'libparse-recdescent-perl':
      ensure => purged;
    'libencode-imaputf7-perl':
      ensure => purged;
  }

  file {
    '/etc/zarafa/cgp-migrate.conf':
      ensure => absent;
    '/usr/local/zarafa-communigate/':
      ensure => absent,
      force  => true;
    '/usr/local/zarafa-communigate/cgp-migrate.sh':
      ensure => absent;
    '/usr/local/zarafa-communigate/cgp-cleanup.sh':
      ensure => absent;
    '/usr/local/zarafa-communigate/cgp.rules':
      ensure => absent;
    '/usr/local/zarafa-communigate/cgp-attribute-strip.txt':
      ensure => absent;
    '/usr/local/zarafa-communigate/cgp-rules-extract.pl':
      ensure => absent;
    '/usr/local/zarafa-communigate/get-folder-name.py':
      ensure => absent;
    '/usr/local/zarafa-communigate/create-folder.py':
      ensure => absent;
    '/usr/local/zarafa-communigate/import-mbox.py':
      ensure => absent;
  }
}
