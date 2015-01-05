# apache2 configuration files
class apache2::config (
  $namevirtualhost = '',
  $service_cert    = $apache2::params::apache2_keyprefix,
  $keypath         = $apache2::params::apache2_keypath,
  $ca_chain_file   = $apache2::params::apache2_ca_chain_file,
  $owner           = $apache2::params::apache2_owner,
  $group           = $apache2::params::apache2_group,
) {

  # ship a standard ssl certificate
  ssl::service_cert { $apache2::config::service_cert:
    keypath       => $apache2::config::keypath,
    ca_chain_file => $apache2::config::ca_chain_file,
    ca_chain_path => $apache2::config::ca_chain_path,
    owner         => $apache2::config::owner,
    group         => $apache2::config::group,
  }

  # Default Einstellungen festlegen.
  File {
    ensure   => present,
    owner    => $apache2::params::apache2_owner,
    group    => $apache2::params::apache2_group,
    mode     => '0644',
    require  => Class['apache2::install'],
    notify   => Class['apache2::service'],
  }

  # Globale Konfiguratonsdateien
  file {
    '/etc/apache2/apache2.conf':
      source   => 'puppet:///modules/apache2/apache2.conf';
    '/etc/apache2/ports.conf':
      content  => template('apache2/ports.conf.erb');
  }
  file { '/etc/logrotate.d/apache2':
    owner    => 'root',
    group    => 'root',
    source   => 'puppet:///modules/apache2/apache2.logrotate',
  }

  file {
    '/etc/apache2/conf.d/':
      ensure    => directory,
      purge     => true,
      recurse   => true;
    '/etc/apache2/conf.d/AAA_MANAGED_BY_PUPPET':
      ensure    => present;
    # SSL Einstellungen
    # benötigt die Variablen $keypath und $keyprefix
    '/etc/apache2/conf.d/ssl_global':
      content   => template('apache2/ssl_global.erb');
    '/etc/apache2/conf.d/charset':
      source    => 'puppet:///modules/apache2/charset';
    '/etc/apache2/conf.d/localized-error-pages':
      source    => 'puppet:///modules/apache2/localized-error-pages';
    '/etc/apache2/conf.d/security':
      source    => 'puppet:///modules/apache2/security';
    '/etc/apache2/conf.d/other-vhosts-access-log':
      source    => 'puppet:///modules/apache2/other-vhosts-access-log';
    ## TODO: move this into a role module. Here is the wrong place.
    '/var/www/default/':
      ensure    => directory,
      purge     => true,
      recurse   => true;
    '/var/www/default/favicon.ico':
      source    => 'puppet:///modules/apache2/favicon.ico';
    '/var/www/index.html':
      ensure    => absent;
    '/var/www/favicon.ico':
      ensure    => absent;
  }

  ## FCGID Einstellungen: Für Datei-Upload benötigt
  file { '/etc/apache2/mods-available/fcgid.conf':
    owner     => 'root',
    group     => 'root',
    source    => 'puppet:///modules/apache2/fcgid.conf',
  }

  file { $apache2::params::apache2_keypath:
    ensure    => directory,
    owner     => 'root',
    group     => 'root',
    purge     => true,
    recurse   => true,
  }

  file { "${apache2::params::apache2_keypath}/AAA_MANAGED_BY_PUPPET":
    ensure    => present,
  }

}
