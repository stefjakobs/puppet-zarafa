# ship certificates for gateway services
class zarafa::gateway_cert (
  $l_ensure = present,
) {
  # same name as in ssl (init.pp)
  ssl::service_cert { 'gateway-ca':
    l_ensure    => $zarafa::gateway_cert::l_ensure,
    private_key => $zarafa::params::ssl_gateway_priv_key,
    certificate => $zarafa::params::ssl_gateway_cert,
  }
}
