# everything that is needed to have a apache2 with mod_php5 working
class php5::mod_php5 inherits php5 {
  include php5::install::mod_php5
}
