source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').strip

gem 'dotenv-rails', groups: %i[development test]

gem 'simplecov', require: false, group: :test

gem 'rails'

gem 'american_date'
gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'decent_exposure'
gem 'devise'
gem 'elasticsearch', '<=7.13' # https://docs.bonsai.io/article/99-searchkick
gem 'friendly_id'
gem 'haml_lint', require: false
gem 'haml-rails'
gem 'importmap-rails'
gem 'iron_teapot', github: 'TalariaSoftware/iron_teapot'
gem 'jbuilder'
gem 'lookbook'
gem 'pagy'
gem 'pg'
gem 'propshaft'
gem 'public_suffix'
gem 'puma'
gem 'pundit'
gem 'rack-canonical-host'
gem 'redis'
gem 'rollbar'
gem 'roo'
gem 'scenic'
gem 'scout_apm'
gem 'searchkick'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'uswds_components', github: 'TalariaSoftware/uswds_components'
gem 'uuid'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'license_finder'
  gem 'rails_best_practices'
  gem 'rubocop'
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'factory_bot'
  gem 'factory_bot-namespaced_factories'
  gem 'faker'
  gem 'pundit-matchers'
  gem 'rails-controller-testing'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'webdrivers'
end
