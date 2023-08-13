RSpec.configure do |config|
  config.before(:suite) do
    Incident.reindex
    Document.reindex
    PostRecord.reindex
    Us::Ca::LosAngeles::Police::Headshots20230321::Headshot.reindex

    Searchkick.disable_callbacks
  end

  config.around(:each, search: true) do |example|
    Searchkick.callbacks(nil) do
      example.run
    end
  end
end
