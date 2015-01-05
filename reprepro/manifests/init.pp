# include everything that is important to have a working reprepro service
class reprepro (
  $gpg_sign_key = ''
) {
  include reprepro::install, reprepro::config
}
