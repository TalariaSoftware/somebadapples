require 'csv'

desc "Populate POST positions"
task import_post_roster: :environment do
  file_path = Rails.public_path.join('data/california-post-roster-2022.csv')

  puts "Parsing CSV"
  table = File.open(file_path) do |file|
    CSV.parse(file, headers: true)
  end

  puts "Getting POST position attributes"
  attributes = table.map(&:to_hash)

  puts "Creating POST position records"
  PostRecord.insert_all(attributes)
end

desc "Populate agencies from POST roster"
task create_post_agencies: :environment do
  puts "Getting agency names"
  agencies = PostRecord.distinct.pluck(:agency)

  agency_parameters = agencies.map do |name|
    {
      name: name.split.join(' '), # normalize spacing
      slug: ActiveSupport::Inflector.parameterize(name),
    }
  end

  puts "Creating agency records"
  Agency.upsert_all(agency_parameters, unique_by: :name)
end

desc "Populate officers from POST roster"
task create_post_officers: :environment do
  puts "Getting officers from POST positions"
  officers = PostRecord.all
                       .select(:officer_id, :officer_name, :post_id)
                       .group(:officer_id, :officer_name, :post_id)

  puts "Getting officer attributes"
  officer_attributes = officers.map do |officer|
    {
      post_id: officer.derived_post_id,
      first_name: officer.first_name,
      middle_name: officer.middle_names.join(' '),
      last_name: officer.last_name,
      suffix: officer.suffix,
      slug: officer.slug,
    }
  end

  puts "Creating officer records"
  Officer.upsert_all(officer_attributes)
end

desc "Populate positions from POST roster"
task create_post_records: :environment do # rubocop:disable Metrics/BlockLength
  puts "Getting POST records"
  post_records = PostRecord.all.select(
    :officer_id, :post_id, :agency, :rank,
    :employment_start_date, :employment_end_date
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

  puts "Getting record attributes"
  record_attributes = post_records.map do |post_record|
    {
      officer_id: officer_hash[post_record.derived_post_id],
      agency_id: agency_hash[post_record.agency.split.join(' ')],
      employment_start: post_record.employment_start,
      employment_end: post_record.employment_end,
      rank: post_record.rank,
    }
  end

  puts "Creating position records"
  Position.upsert_all(record_attributes)

  puts "Updating agency/officer join table"
  Scenic.database.refresh_materialized_view('agencies_officers')
end
