Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']

  config.enabled = false if Rails.env.test?

  # Override Rails env; on Heroku staging is a "production" environment
  # https://devcenter.heroku.com/articles/deploying-to-a-custom-rails-environment
  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env
end
