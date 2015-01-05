# install php5 mapi extension
class php5::install::mapi (
  $l_ensure = present,
) inherits php5::install {
  include repos::zarafa
  include zarafa::params

  if ($l_ensure == present) {
    $mapi_ensure = $zarafa::params::zarafa_version
  } else {
    $mapi_ensure = $l_ensure
  }
  package {
    'php5-mapi':
      ensure  => $mapi_ensure,
      require => Class['repos::zarafa'];
  }
}
