# define a vhost configuration
define apache2::vhost (
  $docroot         = '',
  $serveraliases   = '',
  $proxylist       = [],
  $port            = '80',
  $ssl             = true,
  $listen          = false,
  $template        = 'apache2/vhost.erb',
  $namevirtualhost = '',
  $priority        = '10',
  $servername      = $name,
  $serveradmin     = '',
  $aliassrc        = '',
  $aliasdest       = '',
) {
  include apache2::params

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '444',
    require => Class['apache2::install'],
    notify  => Class['apache2::service'],
  }

  file { "/etc/apache2/sites-available/${priority}-${name}":
    content => template($template),
  }

  if $listen {
    file {"/etc/apache2/conf.d/${name}":
      content => template('apache2/vhost_listen.erb'),
    }
  }

  apache2::site {
    "${priority}-${name}":
      ensure  => present,
      require => File["/etc/apache2/sites-available/${priority}-${name}"],
  }
}

