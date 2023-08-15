class Us::Ca::PostRoster2022::Entry < ApplicationRecord
  self.table_name_prefix = 'us_ca_post_roster2022_'

  extend Pagy::Searchkick
  searchkick

  extend FriendlyId
  friendly_id :officer_id

  SUFFIXES = %w[SR JR JR. JRS II III IV ESQ MR MRS MS].freeze

  validates :officer_id, :officer_name, :post_id, :agency,
    :employment_start_date, :rank, presence: true
  validates :officer_id, uniqueness: true

  def self.import(input_file = Rails.public_path.join('data/us/ca/post-roster-2022.csv'))
    insert_all File.open(input_file) { |file|
      CSV.parse(file, headers: true)
    }.map(&:to_hash)
  end

  def first_name
    return nil if name_withheld?

    given_names.first
  end

  def last_name
    return nil if name_withheld?

    officer_name.split(',').first
  end

  def given_names
    return [] if name_withheld?

    if suffix.present?
      non_last_names[0...-1]
    else
      non_last_names
    end
  end

  def middle_names
    return [] if given_names.empty?

    given_names[1..]
  end

  def suffix
    return '' if name_withheld?

    if non_last_names.last.in?(SUFFIXES)
      non_last_names.last
    else
      ''
    end
  end

  def name_withheld?
    officer_name == 'Name Withheld'
  end

  def post_id_withheld?
    post_id == 'POST ID Withheld'
  end

  private

  def non_last_names
    second_half = officer_name.to_s.split(',').last

    second_half.to_s.split
  end
end
