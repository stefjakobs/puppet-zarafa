# everything that is needed to have a autoconfig service running
# autoconfig: publish mailbox access parameters for thunderbird
# autodiscover: publish active sync access parameters for mobile phones
define autoconfig (
  $ac_template = 'autoconfig/autoconfig-gold.xml.erb',
  $ad_template = 'autoconfig/autodiscover-gold.php.erb',
  $namevhost   = $::fqdn,
  $serveradmin = 'postmaster@example.org',
) {
  include autoconfig::params
  include autoconfig::config
  include apache2::params
  include php5::mod_php5

  File {
    ensure  => present,
    owner   => www-data,
    group   => www-data,
    require => Class['apache2::install'],
    notify  => Class['apache2::service']
  }

  apache2::vhost { "autoconfig.${name}":
    namevirtualhost => $namevhost,
    servername      => "autoconfig.${name}",
    port            => 80,
    priority        => 20,
    serveradmin     => $serveradmin,
    docroot         => "/var/www/${name}",
    template        => 'apache2/autoconfig.erb',
  }
  apache2::vhost { "autodiscover.${name}":
    namevirtualhost => $namevhost,
    servername      => "autodiscover.${name}",
    port            => 443,
    priority        => 20,
    serveradmin     => $serveradmin,
    docroot         => "/var/www/${name}",
    template        => 'apache2/autodiscover.erb',
    aliassrc        => '/autodiscover/autodiscover.xml',
    aliasdest       => "/var/www/${name}/autodiscover/autodiscover.php",
  }

  # autodiscover needs a ssl certificate
  ssl::service_cert { "autodiscover.${name}":
    keypath       => $apache2::params::apache2_keypath,
    owner         => $apache2::params::apache2_owner,
    group         => $apache2::params::apache2_group,
    ca_chain_file => '',
  }

  ## install content files
  file {
    "/var/www/${name}":
      ensure  => directory;
    "/var/www/${name}/mail":
      ensure  => directory;
    "/var/www/${name}/mail/config-v1.1.xml":
      content => template($ac_template);
    "/var/www/${name}/autodiscover":
      ensure  => directory;
    "/var/www/${name}/autodiscover/autodiscover.php":
      content => template($ad_template);
  }
}
