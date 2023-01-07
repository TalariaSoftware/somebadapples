desc "Populate POST positions"
task import_post_roster: :environment do
  file_path = Rails.public_path.join('data/california-post-roster-2022.csv')

  puts "Parsing CSV"
  table = File.open(file_path) do |file|
    CSV.parse(file, headers: true)
  end

  puts "Getting attributes"
  attributes = table.map(&:to_hash)

  puts "Creating records"
  PostPosition.insert_all(attributes) # rubocop:disable Rails/SkipsModelValidations
end

desc "Populate agencies from POST roster"
task create_post_agencies: :environment do
  agencies = PostPosition.pluck(:agency).uniq

  agency_parameters = agencies.map do |name|
    { name: name }
  end

  Agency.upsert_all(agency_parameters, unique_by: :name)
end
