# php5 configuraton parameters
class php5::params {

  $php5_memory_limit        = '128M'
  $php5_upload_max_filesize = '30M'
  $php5_post_max_size       = '32M'
  $php5_date_timezone       = 'Europe\Berlin'
  case $environment {
    'testing': {
      $php5_SMTP            = 'smtp.testing.example.org'
    }
    'staging': {
      $php5_SMTP            = 'smtp.qs.example.org'
    }
    'production': {
      $php5_SMTP            = 'smtp.example.org'
    }
    default: {
      fail("Module ${module_name} is not supported in env ${::environment}")
    }
  }
}
