# install zarafa-monitor
class zarafa::monitor::purged inherits zarafa::monitor::install {

  Package ['zarafa-monitor']{
    ensure  => purged,
  }
  file {
    "${zarafa::params::config_dir}/monitor.cfg":
      ensure   => absent;

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/monitor.cfg.dpkg-dist":
      ensure  => absent;
  }
}
