# Define an apache2 site. Place all site configs into
# /etc/apache2/sites-available and en-/disable them with this type.
#
# You can add a custom require (string) if the site depends on packages
# that aren't part of the default apache2 package. Because of the
# package dependencies, apache2 will automagically be included.

define apache2::site ( $ensure = 'present', $req = 'apache2' ) {
  include apache2::params

  case $ensure {
    'present' : {
      exec { "/usr/sbin/a2ensite ${name}":
        unless  => "/bin/readlink \
                    -e ${apache2::params::apache2_sites_ena}/${name}",
        notify  => Service['apache2'],
        require => Package[$req],
      }
    }
    'absent' : {
      exec { "/usr/sbin/a2dissite ${name}":
        onlyif  => "/bin/readlink \
                    -e ${apache2::params::apach2_sites_ena}/${name}",
        notify  => Service['apache2'],
        require => Package['apache2'],
      }
    }
    default: { err ( "Unknown ensure value: '${ensure}'" ) }
  }
}
