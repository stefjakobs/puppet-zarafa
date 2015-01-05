# autoconfig parameters
class autoconfig::params {

  case $environment {
    'testing': {
      ## Globale Werte
      $emailProvider    = 'example.org'
      $domains          = 'example.org'
      $displayName      = 'TEST'
      $displayShortName = 'TEST Zarafa'

      ## POP3
      $pop3_hostname    = 'mail.example.org'
      $pop3_port        = '995'
      # mögliche Werte: STARTTLS, SSL, PLAIN
      # Zarafa: STARTLS
      $pop3_socketType  = 'SSL'
      # mögliche Werte: password-cleartext, password-encrypted,
      #                 NTLM, GSSAPI, client-IP-address, none
      # Zarafa: nur password-cleartext
      $pop3_auth        = 'password-cleartext'

      $imap_hostname    = 'mail.example.org'
      $imap_port        = '993'
      # mögliche Werte: STARTTLS, SSL, PLAIN
      # Zarafa: PLAIN, SSL, STARTTLS
      $imap_socketType  = 'SSL'
      # mögliche Werte: password-cleartext, password-encrypted,
      #                 NTLM, GSSAPI, client-IP-address, none
      # Problematisch: client-ip-address (thunderbird bleibt stehen)
      # Zarafa: nur password-cleartext
      $imap_auth        = 'password-cleartext'

      $smtp_hostname    = 'smtp.example.org'
      $smtp_port        = '587'
      # mögliche Werte: STARTTLS, SSL, PLAIN
      $smtp_socketType  = 'STARTTLS'
      # mögliche Werte: password-cleartext, password-encrypted,
      #                 NTLM, GSSAPI, client-IP-address, none, smtp-after-pop
      # Problematisch: client-ip-address (thunderbird bleibt stehen)
      $smtp_auth        = 'none'

      $instruction      = 'http://www.example.org/help/mail/thunderbird'
      $configupdate     = 'https://www.example.org/config/mozilla.xml'

      $activesync_url   = 'https://mail.example.org/Microsoft-Server-ActiveSync'
    }
    'staging': {
      ## Globale Werte
      $emailProvider    = 'qs.example.com'
      $domains          = 'stud.qs.example.com'
      $displayName      = 'Zarafa - QS'
      $displayShortName = 'QS Zarafa'

      ## POP3
      $pop3_hostname    = 'pop3.qs.example.com'
      $pop3_port        = '995'
      # mögliche Werte: STARTTLS, SSL, PLAIN
      # Zarafa: STARTLS
      $pop3_socketType  = 'SSL'
      # mögliche Werte: password-cleartext, password-encrypted,
      #                 NTLM, GSSAPI, client-IP-address, none
      # Zarafa: nur password-cleartext
      $pop3_auth        = 'password-cleartext'

      $imap_hostname    = 'imap.qs.example.com'
      $imap_port        = '993'
      # mögliche Werte: STARTTLS, SSL, PLAIN
      # Zarafa: PLAIN, SSL, STARTTLS
      $imap_socketType  = 'SSL'
      # mögliche Werte: password-cleartext, password-encrypted,
      #                 NTLM, GSSAPI, client-IP-address, none
      # Problematisch: client-ip-address (thunderbird bleibt stehen)
      # Zarafa: nur password-cleartext
      $imap_auth        = 'password-cleartext'

      $smtp_hostname    = 'smtp.qs.example.com'
      $smtp_port        = '587'
      # mögliche Werte: STARTTLS, SSL, PLAIN
      $smtp_socketType  = 'STARTTLS'
      # mögliche Werte: password-cleartext, password-encrypted,
      #                 NTLM, GSSAPI, client-IP-address, none, smtp-after-pop
      # Problematisch: client-ip-address (thunderbird bleibt stehen)
      $smtp_auth        = 'password-cleartext'

      $instruction      = 'http://www.example.com/help/mail/thunderbird'
      $configupdate     = 'https://www.example.com/config/mozilla.xml'

      $activesync_url   = 'https://mail.qs.example.com/Microsoft-Server-ActiveSync'
    }
    'production': {
      ## Globale Werte
      $emailProvider    = 'example.com'
      $domains          = 'stud.example.com'
      $displayName      = 'Zarafa Uni Stuttgart'
      $displayShortName = 'Zarafa'

      ## POP3
      $pop3_hostname    = 'pop3.example.com'
      $pop3_port        = '995'
      # mögliche Werte: STARTTLS, SSL, PLAIN
      # Zarafa: STARTLS
      $pop3_socketType  = 'SSL'
      # mögliche Werte: password-cleartext, password-encrypted,
      #                 NTLM, GSSAPI, client-IP-address, none
      # Zarafa: nur password-cleartext
      $pop3_auth        = 'password-cleartext'

      $imap_hostname    = 'imap.example.com'
      $imap_port        = '993'
      # mögliche Werte: STARTTLS, SSL, PLAIN
      # Zarafa: PLAIN, SSL, STARTTLS
      $imap_socketType  = 'SSL'
      # mögliche Werte: password-cleartext, password-encrypted,
      #                 NTLM, GSSAPI, client-IP-address, none
      # Problematisch: client-ip-address (thunderbird bleibt stehen)
      # Zarafa: nur password-cleartext
      $imap_auth        = 'password-cleartext'

      $smtp_hostname    = 'smtp.example.com'
      $smtp_port        = '587'
      # mögliche Werte: STARTTLS, SSL, PLAIN
      $smtp_socketType  = 'STARTTLS'
      # mögliche Werte: password-cleartext, password-encrypted,
      #                 NTLM, GSSAPI, client-IP-address, none, smtp-after-pop
      # Problematisch: client-ip-address (thunderbird bleibt stehen)
      $smtp_auth        = 'password-cleartext'

      $instruction      = 'http://www.example.com/help/mail/thunderbird'
      $configupdate     = 'https://www.example.com/config/mozilla.xml'

      $activesync_url   = 'https://mail.example.com/Microsoft-Server-ActiveSync'
    }
    default: {
      fail("Module ${module_name} is not supported in env ${::environment}")
    }
  }
}

