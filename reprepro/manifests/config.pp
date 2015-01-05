# reprepro configuration
class reprepro::config {
  include users::webusers

  File {
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    require => Class['reprepro::install'],
  }

  file {
    ## create base dir
    '/var/lib/reprepro/':
      ensure  => directory,
      mode    => '0755';
    ## create dir structure
    '/var/lib/reprepro/conf/':
      ensure  => directory,
      require => File['/var/lib/reprepro/'];
    '/var/lib/reprepro/dists/':
      ensure  => directory,
      recurse => true,
      group   => 'www-data',
      require => [
        File['/var/lib/reprepro/'],
        Class['users::webusers']
      ];
    '/var/lib/reprepro/pool/':
      ensure  => directory,
      recurse => true,
      group   => 'www-data',
      require => [
        File['/var/lib/reprepro/'],
        Class['users::webusers']
      ];

    ## configuration files
    '/var/lib/reprepro/conf/distributions':
      content => template('reprepro/distributions.erb'),
      require => File['/var/lib/reprepro/conf/'];
    '/var/lib/reprepro/conf/Release.key':
      source  => "puppet:///modules/reprepro/${reprepro::gpg_sign_key}_pub.gpg",
      require => File['/var/lib/reprepro/conf/'];

    ## Apache konfiguration
    '/var/lib/reprepro/conf/apache.conf':
      source  => 'puppet:///modules/reprepro/apache.conf',
      notify  => Class['apache2::service'],
      require => File['/var/lib/reprepro/conf/'];
    '/etc/apache2/conf.d/reprepro.conf':
      ensure  => link,
      target  => '/var/lib/reprepro/conf/apache.conf',
      notify  => Class['apache2::service'],
      require => [
        File['/var/lib/reprepro/conf/apache.conf'],
        Class['apache2::install']
      ];
  }
}
