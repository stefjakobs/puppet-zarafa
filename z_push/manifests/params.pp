# z-push configuration parameters
class z_push::params {

  case $environment {
    'testing': {
      $zpush_mapi_server  = 'https://node.example.org:237/zarafa'
      $z_push_version     = '2.1.3-1892-1'
    }
    'staging': {
      $zpush_mapi_server  = 'https://mail-znode.qs.example.com:237/zarafa'
      $z_push_version     = '2.1.3-1892-1'
    }
    'production': {
      $zpush_mapi_server  = 'https://mail-znode.example.com:237/zarafa'
      $z_push_version     = '2.1.3-1892-1'
    }
    default: {
      fail("Module ${module_name} is not supported in env ${::environment}")
    }
  }
  $zpush_script_timeout  = '30'
  $zpush_state_dir       = '/var/lib/z-push/'
  $zpush_logfiledir      = '/var/log/z-push/'
  $zpush_logfile         = 'z-push.log'
  $zpush_logerrorfile    = 'z-push-error.log'
  $zpush_loglevel        = 'LOGLEVEL_INFO'
  $zpush_logauthfail     = 'false'
}
