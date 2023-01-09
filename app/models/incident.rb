class Incident < ApplicationRecord
  extend Pagy::Searchkick
  searchkick

  has_many :roles, dependent: :destroy
  has_many :documents, dependent: :destroy
end
