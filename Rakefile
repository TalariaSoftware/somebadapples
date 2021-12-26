# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task default: %i[
  rubocop
  spec
  rails_best_practices
  brakeman:check
  bundle:audit
]
# license_finder removed because it doesn't work with the newer versions of
# Psych. https://github.com/pivotal/LicenseFinder/issues/841
