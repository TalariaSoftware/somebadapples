class Role < ApplicationRecord
  belongs_to :officer
  belongs_to :incident

  accepts_nested_attributes_for :officer
end
