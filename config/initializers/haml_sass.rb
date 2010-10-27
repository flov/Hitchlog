require 'haml/helpers/action_view_mods'
require 'haml/helpers/action_view_extensions'
require 'haml/template'
require 'sass'
require 'sass/plugin'

Sass::Plugin.options[:template_location] = {
  "#{Rails.root}/app/styles" => "#{Rails.root}/public/stylesheets"
}