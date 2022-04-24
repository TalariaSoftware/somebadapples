RSpec.configure do |config|
  config.before(:suite) do
    Officer.reindex
    Searchkick.disable_callbacks
  end

  config.around(:each, search: true) do |example|
    Searchkick.callbacks(nil) do
      example.run
    end
  end
end