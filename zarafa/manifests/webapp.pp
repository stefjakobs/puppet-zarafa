# install zarafa-webapp and enable apache2 service
class zarafa::webapp {
  include zarafa::webapp::install, zarafa::webapp::config
  include zarafa::webapp::service::enabled
}

