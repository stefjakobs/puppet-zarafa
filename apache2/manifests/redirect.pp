# define a redirect
define apache2::redirect (
  $source       = '^/$',
  $destination  = '',
) {
  include apache2::params

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '444',
    require => Class['apache2::install'],
    notify  => Class['apache2::service'],
  }

  file {"/etc/apache2/conf.d/${name}":
    content => template('apache2/redirect.erb'),
  }

}
