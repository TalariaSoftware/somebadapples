require 'rails_helper'

RSpec.describe Agency do
  it { is_expected.to have_many(:positions) }
  it { is_expected.to have_many(:officers).through(:positions) }
end
