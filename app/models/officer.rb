class Officer < ApplicationRecord
  searchkick

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :incident_roles, dependent: :destroy
  has_many :incidents, through: :incident_roles

  def name
    [first_name, middle_name, last_name, suffix].compact_blank.join(' ')
  end
end
