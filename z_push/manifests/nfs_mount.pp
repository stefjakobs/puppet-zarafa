# mount state.dir directory
class z_push::nfs_mount (
  $nfs_host = ''
) {
  include users::webusers
  include nfs

  file { '/var/lib/z-push':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    require => Class['users::webusers'],
  }

  if ( $nfs_host ) {
    mount { '/var/lib/z-push':
      ensure  => 'mounted',
      device  => $nfs_host,
      fstype  => 'nfs',
      options => 'defaults',
      atboot  => true,
      require => [ File['/var/lib/z-push'], Class['nfs'] ],
    }
  }
}
