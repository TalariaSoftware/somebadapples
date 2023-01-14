require 'rails_helper'

RSpec.describe AgencyOfficer do
  it { is_expected.to belong_to(:agency) }
  it { is_expected.to belong_to(:officer) }

  it { is_expected.to be_readonly }
end
