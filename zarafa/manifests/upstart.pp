#
# Selber gebaute upstart skripte, da die von Zarafa nicht rebootfest sind
#

define zarafa::upstart(
  $component = $title,
  ) {
  # Das ist wohl das generelle Vorgehen bei upstart Sripten
  file {"/etc/init.d/zarafa-${component}":
    ensure => link,
    target => '/lib/init/upstart-job',
    mode   => 0755,
    owner  => root,
    group  => root,
  }
  # Sicherstellen, dass kein sysvinit Zeug mehr übrig ist
  file {"/etc/rc0.d/S20zarafa-${component}": ensure => absent}
  file {"/etc/rc0.d/K20zarafa-${component}": ensure => absent}
  file {"/etc/rc0.d/K80zarafa-${component}": ensure => absent}
  file {"/etc/rc1.d/S20zarafa-${component}": ensure => absent}
  file {"/etc/rc1.d/K20zarafa-${component}": ensure => absent}
  file {"/etc/rc1.d/K80zarafa-${component}": ensure => absent}
  file {"/etc/rc2.d/S20zarafa-${component}": ensure => absent}
  file {"/etc/rc2.d/K20zarafa-${component}": ensure => absent}
  file {"/etc/rc2.d/K80zarafa-${component}": ensure => absent}
  file {"/etc/rc3.d/S20zarafa-${component}": ensure => absent}
  file {"/etc/rc3.d/K20zarafa-${component}": ensure => absent}
  file {"/etc/rc3.d/K80zarafa-${component}": ensure => absent}
  file {"/etc/rc4.d/S20zarafa-${component}": ensure => absent}
  file {"/etc/rc4.d/K20zarafa-${component}": ensure => absent}
  file {"/etc/rc4.d/K80zarafa-${component}": ensure => absent}
  file {"/etc/rc5.d/S20zarafa-${component}": ensure => absent}
  file {"/etc/rc5.d/K20zarafa-${component}": ensure => absent}
  file {"/etc/rc5.d/K80zarafa-${component}": ensure => absent}
  file {"/etc/rc6.d/S20zarafa-${component}": ensure => absent}
  file {"/etc/rc6.d/K20zarafa-${component}": ensure => absent}
  file {"/etc/rc6.d/K80zarafa-${component}": ensure => absent}
  # Falls es zarafa server ist, wird noch überprüft ob der MySQL Server läuft und der Socket da ist
  case $component {
    'server' : {
      $parameters = '-F'
      $is_server  = true
      $required   = 'mysql'
    }
    'dagent' : {
      $parameters = '-l'
    }
    default  : {
      # Default ist -F (der deamon geht nicht in den Hintergrund - das erledigt upstart)
      $parameters = '-F'
    }
  }

  file {"/etc/init/zarafa-${component}.conf":
    ensure => file,
    mode   => 0644,
    owner  => root,
    group  => root,
    content => template('zarafa/zarafa-generic-upstart.erb'),
  }
}

# to enable zarafa upstart remove the override file
define zarafa::upstart::enabled (
  $component = $title
  ) {
    file { "/etc/init/zarafa-${component}.override":
      ensure => absent
    }
}

# to disable zarafa via upstart create a override file
define zarafa::upstart::disabled (
  $component = $title
  ) {
    file {"/etc/init/zarafa-${component}.override":
      ensure  => present,
      content => 'manual',
    }
}

# to purge zarafa upstart remove all zarafa component files from /etc/init/
define zarafa::upstart::purged(
  $component = $title
) {
  file {"/etc/init/zarafa-${component}.conf":
    ensure => absent,
  }
}
