require 'rails_helper'

RSpec.describe Position, type: :model do
  it { is_expected.to belong_to(:officer) }
  it { is_expected.to belong_to(:agency) }
end
