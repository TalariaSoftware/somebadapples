require 'rails_helper'

RSpec.describe Agency do
  it { is_expected.to have_many(:positions) }
  it { is_expected.to have_many(:agencies_officers) }
  it { is_expected.to have_many(:officers).through(:agencies_officers) }
end
