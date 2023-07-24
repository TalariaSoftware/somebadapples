require 'csv'

desc "Import LAPD headshots"
task import_lapd_headshots: :environment do
  Us::Ca::LosAngeles::Police::Headshots20230321::Headshot.destroy_all

  dir_path =
    Rails.public_path.join('data/us/ca/police/los_angeles/headshots_20230321')

  file_names = Dir.new(dir_path).children

  file_names.each do |file_name|
    Us::Ca::LosAngeles::Police::Headshots20230321::Headshot.create(
      file_name: file_name,
    )
  end
end
