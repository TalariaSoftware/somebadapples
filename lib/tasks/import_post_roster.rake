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
  agencies = PostPosition.distinct.pluck(:agency)

  agency_parameters = agencies.map do |name|
    { name: name }
  end

  Agency.upsert_all(agency_parameters, unique_by: :name) # rubocop:disable Rails/SkipsModelValidations
end

desc "Populate officers from POST roster"
task create_post_officers: :environment do
  puts "Getting officers"
  officers = PostPosition.all.select(:officer_name, :post_id).group(
    :officer_name, :post_id
  )

  puts "Getting officer parameters"
  officer_attributes = officers.map do |officer|
    {
      post_id: officer.post_id,
      first_name: officer.first_name,
      middle_name: officer.middle_names.join(' '),
      last_name: officer.last_name,
      suffix: officer.suffix,
    }
  end

  puts "Creating records"
  Officer.upsert_all(officer_attributes) # rubocop:disable Rails/SkipsModelValidations
end
