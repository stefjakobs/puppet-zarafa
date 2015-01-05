# zarafa-ical configuration files
class zarafa::ical::config (
  $server_bind      = '0.0.0.0',
  $ical_enable      = 'yes',
  $ical_port        = '8080',
  $icals_enable     = 'no',
  $icals_port       = '8443',
  $server_socket    = $zarafa::params::server_socket,
  $coredump_enabled = $zarafa::params::coredump_enabled,
) {
  include zarafa::gateway_cert

  # Defaultwerte setzen
  File {
    owner       => $zarafa::params::zarafa_user,
    group       => $zarafa::params::zarafa_group,
    require     => Class['zarafa::ical::install'],
    notify      => Class['zarafa::ical::service'],
  }

  # Konfigurationsdatei
  file {
    "${zarafa::params::config_dir}/ical.cfg":
      ensure   => present,
      content  => template('zarafa/ical/ical.cfg.erb');

    ## cleanup to prevent puppet warnings
    "${zarafa::params::config_dir}/ical.cfg.dpkg-dist":
      ensure  => absent;
    '/etc/init.d/zarafa-ical.dpkg-new':
      ensure  => absent;
  }
}
