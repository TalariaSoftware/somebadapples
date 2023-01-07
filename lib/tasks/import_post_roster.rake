desc "Populate officers, positions, and agencies from POST roster"
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
