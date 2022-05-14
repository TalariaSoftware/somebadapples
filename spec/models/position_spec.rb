require 'rails_helper'

RSpec.describe Position, type: :model do
  it { is_expected.to belong_to(:officer) }
  it { is_expected.to belong_to(:agency) }

  it { is_expected.to delegate_method(:name).to(:agency).with_prefix(true) }
end
