class Officer < ApplicationRecord
  searchkick

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :roles, dependent: :destroy
  has_many :incidents, through: :roles

  def name
    [first_name, middle_name, last_name, suffix].compact_blank.join(' ')
  end
end
