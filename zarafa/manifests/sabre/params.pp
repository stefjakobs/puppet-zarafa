# zarafa-sabre / zarafa-communigate configuration parameters
class zarafa::sabre::params {
  case $environment {
    'testing': {
      $data_location     = '/mnt/mail/'
      $tool_location     = '/usr/local/zarafa-communigate/'
      $ical_ip           = '127.0.0.1'
      $ical_port         = '8080'
      $vcard_ip          = '127.0.0.1'
      $vcard_port        = '80'
      $source_imap_ip    = 'mail.example.org'

      $zarafa_admin_user = 'ts000001'
      $zarafa_admin_pw   = 'secret'

      $ramdisk_root      = '/mnt/ram'
      $debug             = '0'
    }
    'staging': {
      $data_location     = '/mmail/CommuniGate/Domains/'
      $tool_location     = '/usr/local/zarafa-communigate/'
      $ical_ip           = '127.0.0.1'
      $ical_port         = '8080'
      $vcard_ip          = '127.0.0.1'
      $vcard_port        = '80'
      $source_imap_ip    = 'mail.example.org'

      $zarafa_admin_user = '<replace with user>'
      $zarafa_admin_pw   = '<replace with password>'

      $ramdisk_root      = '/mnt/ram'
      $debug             = '0'
    }
    'production': {
      $data_location     = '/mail/CommuniGate/Domains/'
      $tool_location     = '/usr/local/zarafa-communigate/'
      $ical_ip           = '127.0.0.1'
      $ical_port         = '8080'
      $vcard_ip          = '127.0.0.1'
      $vcard_port        = '80'
      $source_imap_ip    = 'mail.example.org'

      $zarafa_admin_user = '<replace with user>'
      $zarafa_admin_pw   = '<replace with password>'

      $ramdisk_root      = '/mnt/ram'
      $debug             = '0'
    }
    default: {
      fail("Module ${module_name} is not supported in env ${::environment}")
    }
  }
}
