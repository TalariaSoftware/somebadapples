require 'rails_helper'

RSpec.describe CaCriminalIncident do
  describe "#officer" do
    subject(:officer) { incident.officers }

    let(:incident) do
      create :ca_criminal_incident, first_name: "John", last_name: "Hoover"
    end

    context "when there are no officers" do
      it { is_expected.to be_empty }
    end

    context "when there are no officers with the same first and last name" do
      before do
        create :officer, first_name: "JOHN", last_name: "PINKERTON"
      end

      it { is_expected.to be_empty }
    end

    context "when there is an officer with the same first and last name" do
      let!(:matching_officer) do
        create :officer, first_name: "John", last_name: "Hoover"
      end

      it { is_expected.to eq([matching_officer]) }
    end

    context "when there is an officer with the names cased differently" do
      let!(:matching_officer) do
        create :officer, first_name: "JOHN", last_name: "HOOVER"
      end

      it { is_expected.to eq([matching_officer]) }
    end
  end
end
