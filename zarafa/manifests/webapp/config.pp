# zarafa webapp configuraton
class zarafa::webapp::config {

  include apache2::optimization

  File {
    ensure  => present,
    owner   => 'www-data',
    group   => $zarafa::params::zarafa_group,
    mode    => '0640',
    notify  => Class['zarafa::webapp::service'],
    require => [
      Class['zarafa::webapp::install'],
      Class['users::webusers']
    ],
  }

  ## php5-mapi installiert: /etc/php5/apache2/conf.d/zarafa.ini
  ## Es gilt: /etc/php5/apache2/conf.d/ -> /etc/php5/conf.d/
  ## Mit fcgi brauchen wir aber eine globale zarafa.ini, diese sollte
  ##  somit schon da sein.
  file { '/etc/php5/conf.d/zarafa.ini':
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/zarafa/webapp/zarafa.ini',
  }

  ## mod-php5 configuration
  #file {
  #  '/etc/apache2/sites-available/zarafa-webaccess':
  #    source  => 'puppet:///modules/zarafa/webapp/zarafa-webaccess';
  #  '/etc/apache2/sites-available/zarafa-webapp':
  #    source  => 'puppet:///modules/zarafa/webapp/zarafa-webapp';
  #  '/etc/apache2/sites-available/20-zarafa-ssl':
  #    source  => 'puppet:///modules/zarafa/webapp/20-zarafa-ssl';
  #}

  ## FCGI configuration
  file {
    '/etc/apache2/conf.d/zarafa-webaccess':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => 'puppet:///modules/zarafa/webapp/zarafa-webaccess.fcgi';
    '/etc/apache2/conf.d/zarafa-webapp':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => 'puppet:///modules/zarafa/webapp/zarafa-webapp.fcgi';
  }

  file {
    "${zarafa::params::config_dir}/webaccess-ajax":
      ensure  => directory,
      notify  => undef;
    "${zarafa::params::config_dir}/webaccess-ajax/config.php":
      content => template('zarafa/webapp/config-webaccess.php.erb');
    ## cleanup
    "${zarafa::params::config_dir}/webaccess-ajax/config.php.dpkg-dist":
      ensure  => absent;
  }

  file {
    "${zarafa::params::config_dir}/webapp":
      ensure  => directory,
      notify  => undef;
    "${zarafa::params::config_dir}/webapp/config.php":
      content => template('zarafa/webapp/config-webapp.php.erb');
    ## cleanup
    "${zarafa::params::config_dir}/webapp/config.php.dpkg-dist":
      ensure  => absent;
    ## plugins
    "${zarafa::params::config_dir}/webapp/config-zperformance.php":
      source  => 'puppet:///modules/zarafa/webapp/config-zperformance.php';
    "${zarafa::params::config_dir}/webapp/config-statslogging.php":
      source  => 'puppet:///modules/zarafa/webapp/config-statslogging.php';
    "${zarafa::params::config_dir}/webapp/config-browsercompatibility.php":
      source  => 'puppet:///modules/zarafa/webapp/config-browsercompatibility.php';
    "${zarafa::params::config_dir}/webapp/config-zdeveloper.php":
      source  => 'puppet:///modules/zarafa/webapp/config-zdeveloper.php';
    "${zarafa::params::config_dir}/webapp/config-xmpp.php":
      source  => 'puppet:///modules/zarafa/webapp/config-xmpp.php';
    "${zarafa::params::config_dir}/webapp/config-webappmanual.php":
      source  => 'puppet:///modules/zarafa/webapp/config-webappmanual.php';
    "${zarafa::params::config_dir}/webapp/config-extbox.php":
      source  => 'puppet:///modules/zarafa/webapp/config-extbox.php';
    "${zarafa::params::config_dir}/webapp/config-pdfbox.php":
      source  => 'puppet:///modules/zarafa/webapp/config-pdfbox.php';
    "${zarafa::params::config_dir}/webapp/config-webodf.php":
      source  => 'puppet:///modules/zarafa/webapp/config-webodf.php';
    "${zarafa::params::config_dir}/webapp/config-feedback.php":
      source  => 'puppet:///modules/zarafa/webapp/config-feedback.php';
  }

  ## set .htaccess file for fcgi configuration
  file {
    '/usr/share/zarafa-webapp/.htaccess':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => 'puppet:///modules/zarafa/webapp/htaccess';
    '/usr/share/zarafa-webaccess/.htaccess':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => 'puppet:///modules/zarafa/webapp/htaccess';
  }

  ## costumize webapp appearance
  file {
    '/usr/share/zarafa-webapp/client/resources/images/Zarafa_logo_transparent.png':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => 'puppet:///modules/zarafa/webapp/logo_uni_244x55.png';
    '/usr/share/zarafa-webapp/client/resources/images/zlogo.png':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => "puppet:///modules/zarafa/webapp/logo_uni_133x30_${environment}.png";
    '/usr/share/zarafa-webapp/client/resources/images/login.png':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => "puppet:///modules/zarafa/webapp/webapp-login_${environment}.png";
  }

  ## costumize webacces appearance
  file {
    '/usr/share/zarafa-webaccess/client/layout/img/login.jpg':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => "puppet:///modules/zarafa/webapp/webaccess-login_${environment}.png";
  }

  ## disable feedback plugin
  file {
    '/usr/share/zarafa-webapp/plugins/feedback':
      ensure  => absent,
      recurse => true,
      purge   => true,
      force   => true;
  }
  ## disable example plugin
  file {
    '/usr/share/zarafa-webapp/plugins/example':
      ensure  => absent,
      recurse => true,
      purge   => true,
      force   => true;
  }

  ## disable worker configuration
  file {
    '/etc/apache2/sites-enabled/zarafa-webaccess':
      ensure  => absent;
    '/etc/apache2/sites-enabled/zarafa-webapp':
      ensure  => absent;
    ## cleanup
    '/etc/apache2/sites-available/zarafa-webapp.dpkg-dist':
      ensure  => absent;
    '/etc/apache2/sites-available/zarafa-webaccess.dpkg-dist':
      ensure  => absent;
  }
}
