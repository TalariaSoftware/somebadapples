require 'csv'

desc "Import LAPD headshots"
task import_lapd_headshots: :environment do
  LapdHeadshot.destroy_all

  file_names = Dir.new(Rails.public_path.join('data/lapd_headshots')).children

  file_names.each do |file_name|
    LapdHeadshot.create(file_name: file_name)
  end
end
