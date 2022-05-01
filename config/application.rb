require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module BadApples
  class Application < Rails::Application
    config.load_defaults 7.0

    config.generators.controller_specs = true
    config.generators.helper = false
    config.generators.request_specs = false
    config.generators.orm :active_record, primary_key_type: :uuid
    config.generators.stylesheets = false
    config.generators.test_framework = :rspec
    config.generators.view_specs = false

    config.view_component.preview_paths <<
      Rails.root.join('spec/components/previews')
    config.view_component.preview_paths <<
      UswdsComponents::Engine.root.join('spec/components/previews')
    config.view_component.default_preview_layout = 'component_preview'
    config.view_component.show_previews = true
    config.view_component.show_previews_source = true
  end
end
