# everything that is needed to have a working z-push service
class z_push (
  $nfs_host = ''
) {
  include z_push::install, z_push::config
  class { 'z_push::nfs_mount':
    nfs_host => $z_push::nfs_host
  }
}
