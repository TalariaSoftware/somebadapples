require 'rails_helper'

RSpec.describe Incident, type: :model do
  it { is_expected.to have_many(:roles) }
  it { is_expected.to have_many(:external_documents) }
end
