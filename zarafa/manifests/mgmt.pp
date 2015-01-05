# install management tools (zarafa-admin, etc)
class zarafa::mgmt {
  include zarafa::mgmt::install, zarafa::mgmt::config
  include php5::mapi
  include munin
}

