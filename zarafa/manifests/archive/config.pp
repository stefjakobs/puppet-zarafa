# zarafa archive configuration
class zarafa::archive::config {
#   file { "/etc/zarafa/server.cfg":
#      ensure => present,
#      owner => "root",
#      group => "root",
#      mode  => "0440",
#      source => "puppet://$puppetserver/modules/zarafa/server.cfg",
#      require => Class["zarafa::install"],
#      notify => Class["zarafa::service"],
#   }
}
