# purge zarafa-ical
class zarafa::ical::purged {
  include zarafa::params
  class { 'zarafa::gateway_cert':
    l_ensure  => absent,
  }

  package { 'zarafa-ical':
    ensure    => purged,
  }

  file {
    "${zarafa::params::config_dir}/ical.cfg":
      ensure  => absent;

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/ical.cfg.dpkg-dist":
      ensure  => absent;
  }
}
