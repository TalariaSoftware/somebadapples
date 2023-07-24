class Us::Ca::LosAngeles::Police::Headshots20230321::Headshot < ApplicationRecord # rubocop:disable Layout/LineLength
  self.table_name_prefix = 'us_ca_los_angeles_police_headshots20230321_'
  extend FriendlyId
  friendly_id :file_name, use: :slugged

  extend Pagy::Searchkick
  searchkick

  validates :file_name, presence: true, uniqueness: true

  FILE_DIR = '/data/us/ca/police/los_angeles/headshots_20230321'.freeze

  def file_path
    "#{FILE_DIR}/#{URI::DEFAULT_PARSER.escape(file_name)}"
  end

  def officer_name
    file_name.split(' - ').first
  end

  def serial_number
    file_name.split(' - ').last.gsub(/[^0-9]/, '')
  end
end
