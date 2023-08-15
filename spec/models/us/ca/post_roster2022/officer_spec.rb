require 'rails_helper'

RSpec.describe Us::Ca::PostRoster2022::Officer do
  subject(:officer) { Us::Ca::PostRoster2022::Officer.new(post_id: post_id) }

  let(:post_id) { "A12-B34" }

  describe "#entries" do
    subject { officer.entries }

    context "when there are no entries" do
      it { is_expected.to be_blank }
    end

    context "when there are entries with a different POST ID" do
      before { create :'us/ca/post_roster2022_entry', post_id: "Z98-Y76" }

      it { is_expected.to be_blank }
    end

    context "when there are entries with the same POST ID" do
      let!(:entry) { create :'us/ca/post_roster2022_entry', post_id: "A12-B34" }

      it { is_expected.to eq([entry]) }
    end
  end
end
