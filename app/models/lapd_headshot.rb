class LapdHeadshot < ApplicationRecord
  validates :file_name, presence: true, uniqueness: true

  def file_path
    "/data/lapd_headshots/#{URI::DEFAULT_PARSER.escape(file_name)}"
  end

  def officer_name
    file_name.split(' - ').first
  end

  def serial_number
    file_name.split(' - ').last.gsub(/[^0-9]/, '')
  end
end
