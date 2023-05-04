require 'csv'

desc "Import LAPD headshots"
task import_lapd_headshots: :environment do
  Us::Ca::LosAngeles::Police::Headshots20230321::Headshot.destroy_all

  file_names = Dir.new(Rails.public_path.join('data/us/ca/police/los_angeles/headshots_20230321')).children

  file_names.each do |file_name|
    Us::Ca::LosAngeles::Police::Headshots20230321::Headshot.create(file_name: file_name)
  end
end
