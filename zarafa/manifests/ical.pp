# install zarafa-ical service and enable ical service
class zarafa::ical (
  $server_bind      = '0.0.0.0',
  $ical_enable      = 'yes',
  $ical_port        = '8080',
  $icals_enable     = 'no',
  $icals_port       = '8443',
  $server_socket    = $zarafa::params::server_socket,
  $coredump_enabled = $zarafa::params::coredump_enabled,
) {
  include zarafa::ical::install
  class { 'zarafa::ical::config':
    server_bind      => $zarafa::ical::server_bind,
    ical_enable      => $zarafa::ical::ical_enable,
    ical_port        => $zarafa::ical::ical_port,
    icals_enable     => $zarafa::ical::icals_enable,
    icals_port       => $zarafa::ical::icals_port,
    server_socket    => $zarafa::ical::server_socket,
    coredump_enabled => $zarafa::ical::coredump_enabled,
  }
  include zarafa::ical::service::enabled
}
