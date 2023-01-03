require 'rails_helper'

RSpec.describe Role do
  it { is_expected.to belong_to(:officer) }
  it { is_expected.to belong_to(:incident) }
end
