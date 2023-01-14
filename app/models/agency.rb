class Agency < ApplicationRecord
  extend Pagy::Searchkick
  searchkick

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, uniqueness: true

  has_many :positions, dependent: :destroy

  has_many :agencies_officers, class_name: 'AgencyOfficer', dependent: :destroy
  has_many :officers, through: :agencies_officers
end
