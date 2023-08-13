class Incident < ApplicationRecord
  extend Pagy::Searchkick
  searchkick

  has_many :documents, dependent: :destroy
end
