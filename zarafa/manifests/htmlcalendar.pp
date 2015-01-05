class zarafa::htmlcalendar (
  $domain = undef,
) {
  file {'/var/www/seminarraum':
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
    mode   => '755',
  }
  file {'/var/www/seminarraum/index.html':
    ensure => file,
    owner  => 'www-data',
    group  => 'www-data',
    mode   => '644',
  }
  # Nice CSS file
  file {'/var/www/seminarraum/calendar.css':
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
    mode   => '644',
    source => "puppet:///modules/zarafa/ical2html.css",
  }
  # Binary because ical2html is not shiped with preceise
  # do: apt-get install ical2html would work
  # Compiled for intel x64 on precise
  package{'libical0':}
  file {'/usr/local/bin/ical2html':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => 755,
    source => "puppet:///modules/zarafa/ical2html-ubuntu_12.04",
  }
  file {'/usr/local/bin/ical2html-script':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => 755,
    source => "puppet:///modules/zarafa/ical2html-script",
  }
  # Run every 5 minutes
  cron {'ical2html':
    command => '/usr/local/bin/ical2html-script',
    user    => www-data,
    minute  => '*/5'
  }
  apache2::vhost {$domain:
    namevirtualhost => $domain,
    servername      => $domain,
    port            => 80,
    priority        => 90,
    serveradmin     => 'postmaster@example.com',
    docroot         => '/var/www/seminarraum',
    template        => 'apache2/autoconfig.erb',
  }
}
