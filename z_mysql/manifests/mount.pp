# create a FS on a harddisk and mount that harddisk
class z_mysql::mount (
  $device = '',
  $fstype = 'ext4',
) {
  include z_mysql::params
  include users::mysqlusers

  #$pv2     = '/dev/sdd1'

  # !! Problem mit Puppet Bug: http://projects.puppetlabs.com/issues/4409 !!
  #filesystem { $pv1:
  #  ensure  => present,
  #  fs_type => $fstype,
  #}

  #filesystem { $pv2:
  #  ensure  => present,
  #  fs_type => $fstype,
  #}

  ## Mountpoint für MySQL Database
  if ( $z_mysql::mount::device ) {
    mount { $z_mysql::params::mysql_mountpoint:
      ensure  => 'mounted',
      device  => $z_mysql::mount::device,
      fstype  => $z_mysql::mount::fstype,
      options => 'defaults',
      atboot  => true,
      require => File[$z_mysql::params::mysql_mountpoint],
      #require => [ File[$z_mysql::params::mysql_datadir], Filesystem[$pv1] ],
    }

    file { "${z_mysql::params::mysql_mountpoint}/lost+found/":
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0700',
      require => [
        File[$z_mysql::params::mysql_mountpoint],
        Mount[$z_mysql::params::mysql_mountpoint],
      ],
    }
  } else {
    fail("Module ${module_name}: No Device for MySQL DB named.")
  }


  # /var/lib/mysql
  file { $z_mysql::params::mysql_mountpoint:
    ensure  => directory,
    owner   => $z_mysql::params::mysql_owner,
    group   => $z_mysql::params::mysql_group,
    mode    => $z_mysql::params::mysql_dir_mode,
    require => Class['users::mysqlusers'],
  }

  # /var/lib/mysql/db
  file { $z_mysql::params::mysql_datadir :
    ensure  => directory,
    owner   => $z_mysql::params::mysql_owner,
    group   => $z_mysql::params::mysql_group,
    mode    => $z_mysql::params::mysql_dir_mode,
    require => [
      Class['users::mysqlusers'],
      Mount[$z_mysql::params::mysql_mountpoint],
    ],
  }
}
