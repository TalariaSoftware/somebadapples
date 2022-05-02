class Incident < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :external_documents, dependent: :destroy
end
