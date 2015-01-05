# install z-push
class z_push::install {
  include z_push::params
  include repos::zarafa

  package { 'z-push':
    ensure  => $z_push::params::z_push_version,
    require => [ Class['php5::cgi'],
                 Class['z_push::nfs_mount'],
                 Class['repos::zarafa'],
               ],
  }
}
