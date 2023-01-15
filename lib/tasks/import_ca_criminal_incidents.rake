require 'csv'

desc "Populate CA criminal incidents"
task import_ca_criminal_incidents: :environment do
  file_path = Rails.public_path.join('data/california-criminal-cops.csv')

  puts "Parsing CSV"
  table = File.open(file_path) do |file|
    CSV.parse(file, headers: true)
  end

  puts "Getting incident attributes"
  attributes = table.map(&:to_hash)

  puts "Creating CA criminal incident records"
  CaCriminalIncident.insert_all(attributes) # rubocop:disable Rails/SkipsModelValidations
end
