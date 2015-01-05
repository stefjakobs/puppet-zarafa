# install zarafa monitor and enable service
class zarafa::monitor (
  $quota_check_interval = '60'
) {
  include zarafa::monitor::install, zarafa::monitor::config
  include zarafa::monitor::service::enabled
}

