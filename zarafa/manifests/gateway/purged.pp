# purge zarafa-gateway
class zarafa::gateway::purged {
  include zarafa::params
  class { 'zarafa::gateway_cert':
    l_ensure  => absent,
  }

  package { 'zarafa-gateway':
    ensure    => purged,
  }

  file {
    "${zarafa::params::config_dir}/gateway.cfg":
      ensure  => absent;

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/gateway.cfg.dpkg-dist":
      ensure  => absent;
  }
}
