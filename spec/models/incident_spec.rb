require 'rails_helper'

RSpec.describe Incident, type: :model do
  it { is_expected.to belong_to(:officer) }
  it { is_expected.to have_many(:external_documents) }
end
