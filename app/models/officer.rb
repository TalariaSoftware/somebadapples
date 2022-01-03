class Officer < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :incidents, dependent: :destroy

  def name
    [first_name, middle_name, last_name, suffix].compact_blank.join(' ')
  end
end
