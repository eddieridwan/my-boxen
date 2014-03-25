class projects::amc-cts {
  require homebrew

  package { 'fontconfig': }
  package { 'freetds': }
  package { 'freetype': }
  package { 'ghostscript': }
  package { 'jpeg': }
  package { 'libpng': }
  package { 'libtiff': }
  package { 'libtool': }
  package { 'phantomjs': }
  package { 'pkg-config': }

  package { 'imagemagick':
    ensure => present,
    install_options => [
      '--with-ghostscript'
    ]
  }

  mysql::db { 'credentials_development': }
  mysql::db { 'credentials_test': }

  boxen::project { 'amc-cts':
    source => 'git@github.com:amc-projects/cts-rails.git',
    ruby   => '1.9.3',
    nginx  => true,
    mysql  => true
  }
}
