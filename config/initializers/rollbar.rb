Rollbar.configure do |config|
  config.access_token = ENV.fetch('ROLLBAR_ACCESS_TOKEN', nil)

  config.enabled = false if Rails.env.test?

  # Override Rails env; on Heroku staging is a "production" environment
  # https://devcenter.heroku.com/articles/deploying-to-a-custom-rails-environment
  config.environment = ENV.fetch('ROLLBAR_ENV', Rails.env)
end
