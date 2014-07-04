class people::hughevans {
  # Applications

  include alfred
  include dropbox
  include onepassword
  include rdio
  include sequel_pro
  include sublime_text_3
  include vlc
  include wunderlist

  # Projects

  include projects::all

  # OS X

  ## Global

  osx::recovery_message { 'If this Mac is found, please call +61 419 129 175': }

  include osx::global::disable_key_press_and_hold # this does not appear to work
  include osx::global::enable_keyboard_control_access # this does not appear to work
  include osx::global::expand_print_dialog
  include osx::global::expand_save_dialog
  include osx::disable_app_quarantine
  include osx::no_network_dsstores

  class { 'osx::global::key_repeat_delay':
    delay => 1
  }

  class { 'osx::global::key_repeat_rate':
    rate => 0
  }

  ## Dock

  include osx::dock::2d # this does not appear to work
  include osx::dock::autohide # this does not appear to work
  include osx::dock::clear_dock
  include osx::dock::dim_hidden_apps # this does not appear to work
  include osx::dock::hide_indicator_lights # this does not appear to work

  ## Finder

  include osx::finder::empty_trash_securely
  include osx::finder::unhide_library

  # Java

  ## Disable Java in web browsers

  # file { "/Library/Application Support/Oracle/Java/javaws":
  #   ensure => absent
  # }

  # file { "/Library/Application Support/Oracle/Java/Info.plist":
  #   ensure => link,
  #   target => '/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Disabled.plist'
  # }

  # Sublime Text 3

  file { "/opt/boxen/bin/subl":
    ensure => link,
    target => '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'
  }

  ## Packages

  sublime_text_3::package { 'SublimeLinter':
    source => 'SublimeLinter/SublimeLinter3'
  }

  sublime_text_3::package { 'SublimeLinter-jsxhint':
    source => 'SublimeLinter/SublimeLinter-jsxhint'
  }

  sublime_text_3::package { 'SublimeLinter-jshint':
    source => 'SublimeLinter/SublimeLinter-jshint'
  }

  sublime_text_3::package { 'SublimeLinter-ruby':
    source => 'SublimeLinter/SublimeLinter-ruby'
  }

  sublime_text_3::package { 'SublimeLinter-html-tidy':
    source => 'SublimeLinter/SublimeLinter-html-tidy'
  }

  sublime_text_3::package { 'CoffeeScript':
    source => 'aponxi/sublime-better-coffeescript'
  }

  sublime_text_3::package { 'ColorPicker':
    source => 'weslly/ColorPicker'
  }

  sublime_text_3::package { 'Theme - Soda':
    source => 'buymeasoda/soda-theme'
  }

  sublime_text_3::package { 'Theme - Railscasts':
    source => 'tdm00/sublime-theme-railscasts'
  }

  sublime_text_3::package { 'SCSS':
    source => 'danro/SCSS-sublime'
  }

  sublime_text_3::package { 'Puppet':
    source => 'eklein/sublime-text-puppet'
  }

  sublime_text_3::package { 'Slim':
    source => 'slim-template/ruby-slim.tmbundle'
  }

  sublime_text_3::package { 'PrettyJson':
    source => 'dzhibas/SublimePrettyJson'
  }

  sublime_text_3::package { 'TrailingSpaces':
    source => 'SublimeText/TrailingSpaces'
  }

  sublime_text_3::package { 'CodeFormatter':
    source => 'akalongman/sublimetext-codeformatter'
  }

  # Dotfiles

  $home = "/Users/${::luser}"
  $dotfiles = "${boxen::config::srcdir}/dotfiles"

  repository { $dotfiles:
    source => "${::github_login}/dotfiles"
  }

  exec { "cp -r ${dotfiles}/fonts/SourceCodePro ${home}/Library/Fonts/SourceCodePro":
    creates => "${home}/Library/Fonts/SourceCodePro",
    require => Repository[$dotfiles]
  }

  file { "${home}/.bash_profile":
    ensure => "link",
    target => "${dotfiles}/bash_profile",
    require => Repository[$dotfiles]
  }

  file { "${home}/.irbrc":
    ensure => "link",
    target => "${dotfiles}/irbrc",
    require => Repository[$dotfiles]
  }

  file { "${home}/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings":
    ensure => "link",
    target => "${dotfiles}/sublime-settings",
    require => Repository[$dotfiles]
  }

  # Node modules

  nodejs::module { 'STRML/JSXHint':
    node_version => 'v0.10.13'
  }

  nodejs::module { 'react-tools':
    node_version => 'v0.10.13'
  }

  nodejs::module { 'jshint':
    node_version => 'v0.10.13'
  }
}
