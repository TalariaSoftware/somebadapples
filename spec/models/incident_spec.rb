require 'rails_helper'

RSpec.describe Incident do
  it { is_expected.to have_many(:documents) }
end
