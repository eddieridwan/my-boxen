class people::eddieridwan {

	notify { 'class people::eddieridwan declared': }

  # Applications

  include sublime_text_3

  # Projects

  include projects::all

  # OS X

  ## Global

  osx::recovery_message { 'If this Mac is found, please call +61 421 194 607': }

  ## Finder

  include osx::finder::empty_trash_securely
  include osx::finder::unhide_library

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

  sublime_text_3::package { 'ColorPicker':
    source => 'weslly/ColorPicker'
  }

  sublime_text_3::package { 'SCSS':
    source => 'danro/SCSS-sublime'
  }

  sublime_text_3::package { 'Puppet':
    source => 'eklein/sublime-text-puppet'
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

}
