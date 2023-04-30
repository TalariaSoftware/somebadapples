require 'rails_helper'

RSpec.describe Us::Ca::LosAngeles::Police::Roster20220820::EntryPolicy do
  subject do
    Us::Ca::LosAngeles::Police::Roster20220820::EntryPolicy.new user, record
  end

  let(:resolved_scope) do
    Us::Ca::LosAngeles::Police::Roster20220820::EntryPolicy::Scope
      .new(user, Us::Ca::LosAngeles::Police::Roster20220820::Entry.all).resolve
  end
  let(:record) { build :'us/ca/los_angeles/police/roster20220820_entry' }

  let(:user) { nil }

  it { is_expected.to permit_action(:index) }
  it { is_expected.to permit_action(:show) }
  it { is_expected.to forbid_action(:create) }
  it { is_expected.to forbid_action(:new) }
  it { is_expected.to forbid_action(:update) }
  it { is_expected.to forbid_action(:edit) }
  it { is_expected.to forbid_action(:destroy) }

  describe 'scope' do
    let!(:record) { create :'us/ca/los_angeles/police/roster20220820_entry' }

    it "includes the record from resolved scope" do
      expect(resolved_scope).to include(record)
    end
  end
end
