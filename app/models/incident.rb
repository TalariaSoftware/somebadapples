class Incident < ApplicationRecord
  belongs_to :officer
  has_many :external_documents, dependent: :destroy
end
