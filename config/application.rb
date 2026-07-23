require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Furima41273
  class Application < Rails::Application
    config.load_defaults 7.0 
    
    config.active_record.async_query_executor = nil
    config.active_record.query_transformers = []

    config.autoload_lib(ignore: %w(assets tasks))
    config.i18n.default_locale = :ja
  end
end
