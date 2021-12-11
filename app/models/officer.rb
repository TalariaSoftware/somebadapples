class Officer < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :incidents, dependent: :destroy

  def name
    [first_name, last_name].compact.join(' ')
  end
end
