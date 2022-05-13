class Incident < ApplicationRecord
  searchkick

  has_many :roles, dependent: :destroy
  has_many :documents, dependent: :destroy
end
