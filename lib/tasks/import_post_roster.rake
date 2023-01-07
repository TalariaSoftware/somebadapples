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
  PostPosition.insert_all(attributes)
end

desc "Populate agencies from POST roster"
task create_post_agencies: :environment do
  agencies = PostPosition.distinct.pluck(:agency)

  agency_parameters = agencies.map do |name|
    { name: name }
  end

  Agency.upsert_all(agency_parameters, unique_by: :name)
end

desc "Populate officers from POST roster"
task create_post_officers: :environment do
  puts "Getting officers"
  officers = PostPosition.all.select(:officer_name, :post_id).group(
    :officer_name, :post_id
  )

  puts "Getting officer attributes"
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
  Officer.upsert_all(officer_attributes)
end

desc "Populate positions from POST roster"
task create_post_positions: :environment do # rubocop:disable Metrics/BlockLength
  puts "Getting positions"
  post_positions = PostPosition.all.select(
    :post_id, :agency, :employment_start_date, :employment_end_date, :rank
  )

  puts "Preloading officers"
  officer_hash = {}
  Officer.all.select(:id, :post_id).each do |officer|
    officer_hash[officer.post_id] = officer.id
  end

  puts "Preloading agencies"
  agency_hash = {}
  Agency.all.select(:id, :name).each do |agency|
    agency_hash[agency.name] = agency.id
  end

  puts "Getting position attributes"
  position_attributes = post_positions.map do |post_position|
    {
      officer_id: officer_hash[post_position.post_id],
      agency_id: agency_hash[post_position.agency],
      employment_start: post_position.employment_start,
      employment_end: post_position.employment_end,
      rank: post_position.rank,
    }
  end

  puts "Creating records"
  Position.upsert_all(position_attributes)
end
