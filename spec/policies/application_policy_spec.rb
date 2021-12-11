require 'rails_helper'

RSpec.describe ApplicationPolicy do
  subject { ApplicationPolicy.new nil, record }

  let(:resolved_scope) do
    ApplicationPolicy::Scope.new(nil, Officer.all).resolve
  end
  let(:record) { Officer.new }

  it { is_expected.to permit_action(:index) }
  it { is_expected.to permit_action(:show) }
  it { is_expected.to forbid_action(:create) }
  it { is_expected.to forbid_action(:new) }
  it { is_expected.to forbid_action(:update) }
  it { is_expected.to forbid_action(:edit) }
  it { is_expected.to forbid_action(:destroy) }

  describe 'scope' do
    let!(:record) { Officer.create }

    it "includes the record from resolved scope" do
      expect(resolved_scope).to include(record)
    end
  end
end
