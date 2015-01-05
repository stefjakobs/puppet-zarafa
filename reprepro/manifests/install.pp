# install packages needed for reprepro
class reprepro::install {
  package { 'reprepro':
    ensure  => present,
  }
}
