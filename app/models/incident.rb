class Incident < ApplicationRecord
  has_many :incident_roles, dependent: :destroy
  has_many :external_documents, dependent: :destroy
end
