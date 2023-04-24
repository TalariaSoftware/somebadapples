source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').strip

gem 'dotenv-rails', groups: %i[development test]

gem 'simplecov', require: false, group: :test

gem 'rails'

gem 'bootsnap', require: false
gem 'decent_exposure'
gem 'devise', github: 'heartcombo/devise'
gem 'elasticsearch', '<=7.13' # https://docs.bonsai.io/article/99-searchkick
gem 'friendly_id'
gem 'haml_lint', require: false
gem 'haml-rails'
gem 'importmap-rails'
gem 'iron_teapot', github: 'TalariaSoftware/iron_teapot'
gem 'jbuilder'
gem 'lookbook', '>= 2.0.0-rc2'
gem 'pagy'
gem 'pg'
gem 'public_suffix'
gem 'puma'
gem 'pundit'
gem 'rack-canonical-host'
gem 'redis'
gem 'rollbar'
# gem 'sassc-rails'
gem 'scenic'
gem 'scout_apm'
gem 'searchkick'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'uswds_components', github: 'TalariaSoftware/uswds_components'
gem 'uuid'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # Version 1.7.1 incorrectly leaves irb and readline out of its dependencies
  # This causes an error on GitHub actions:
  # "Downloading debug-1.7.1 revealed dependencies not in the API or the
  # lockfile (irb (>= 1.5.0), reline (>= 0.3.1))."
  # GitHub issue: https://github.com/ruby/debug/issues/852
  gem 'debug', '< 1.7.0', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'license_finder'
  gem 'rails_best_practices'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'factory_bot'
  gem 'faker'
  gem 'pundit-matchers'
  gem 'rails-controller-testing'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'webdrivers'
end
