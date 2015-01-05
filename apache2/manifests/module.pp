# Define an apache2 module. Debian packages place the module config
# into /etc/apache2/mods-available.
#
# You can add a custom require (string) if the module depends on
# packages that aren't part of the default apache2 package. Because of
# the package dependencies, apache2 will automagically be included.

define apache2::module ( $ensure = 'present', $req = 'apache2' ) {
  include apache2::params
  include apache2::service

  case $ensure {
    'present' : {
      exec { "/usr/sbin/a2enmod ${name}":
        unless  => "/bin/readlink \
                    -e ${apache2::params::apache2_mods_ena}/${name}.load",
        notify  => Service['apache2'],
        require => Package[$req],
      }
    }
    'absent': {
      exec { "/usr/sbin/a2dismod ${name}":
        onlyif  => "/bin/readlink \
                    -e ${apache2::params::apache2_mods_ena}/${name}.load",
        notify  => Service['apache2'],
        require => Package['apache2'],
      }
    }
    default: { err ( "Unknown ensure value: '${ensure}'" ) }
  }
}
