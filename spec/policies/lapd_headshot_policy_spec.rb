require 'rails_helper'

RSpec.describe LapdHeadshotPolicy do
  subject { LapdHeadshotPolicy.new user, record }

  let(:resolved_scope) do
    LapdHeadshotPolicy::Scope.new(user, LapdHeadshot.all).resolve
  end
  let(:record) { build :post_record }

  let(:user) { nil }

  it { is_expected.to permit_action(:index) }
  it { is_expected.to permit_action(:show) }
  it { is_expected.to forbid_action(:create) }
  it { is_expected.to forbid_action(:new) }
  it { is_expected.to forbid_action(:update) }
  it { is_expected.to forbid_action(:edit) }
  it { is_expected.to forbid_action(:destroy) }

  describe 'scope' do
    let!(:record) { create :lapd_headshot }

    it "includes the record from resolved scope" do
      expect(resolved_scope).to include(record)
    end
  end
end
