require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module BadApples
  class Application < Rails::Application
    config.load_defaults 7.0

    config.generators.controller_specs = true
    config.generators.helper = false
    config.generators.request_specs = false
    config.generators.stylesheets = false
    config.generators.test_framework = :rspec
    config.generators.view_specs = false
  end
end
