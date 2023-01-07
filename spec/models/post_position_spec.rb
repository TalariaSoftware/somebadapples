require 'rails_helper'

RSpec.describe PostPosition do
  it { is_expected.to belong_to(:position) }

  describe "#last_name" do
    subject { record.last_name }

    context "when a name is given" do
      let(:record) { described_class.new(officer_name: "Doe, Jane") }

      it { is_expected.to eq("Doe") }
    end

    context "when the officer's name is withheld" do
      let(:record) { described_class.new(officer_name: "Name Withheld") }

      it { is_expected.to be_blank }
    end
  end

  describe "#first_name" do
    subject { record.first_name }

    context "when the record has one given name" do
      let(:record) { described_class.new(officer_name: "Doe, Jane") }

      it { is_expected.to eq("Jane") }
    end

    context "when the record has multiple given names" do
      let(:record) { described_class.new(officer_name: "Doe, Jane Rodham") }

      it { is_expected.to eq("Jane") }
    end

    context "when the record has a suffix" do
      let(:record) { described_class.new(officer_name: "Doe, John JR") }

      it { is_expected.to eq("John") }
    end

    context "when the officer's name is withheld" do
      let(:record) { described_class.new(officer_name: "Name Withheld") }

      it { is_expected.to be_nil }
    end
  end

  describe "#middle_names" do
    subject { record.middle_names }

    context "when the record has one given name" do
      let(:record) { described_class.new(officer_name: "Doe, Jane") }

      it { is_expected.to be_empty }
    end

    context "when the record has multiple given names" do
      let(:record) do
        described_class.new(officer_name: "Doe, Jane Hillary Rodham")
      end

      it { is_expected.to eq(%w[Hillary Rodham]) }
    end

    context "when the record has a suffix" do
      let(:record) { described_class.new(officer_name: "Doe, John JR") }

      it { is_expected.to be_empty }
    end

    context "when the record has a middle name and a suffix" do
      let(:record) { described_class.new(officer_name: "Doe, John Jacob JR") }

      it { is_expected.to eq(["Jacob"]) }
    end

    context "when the officer's name is withheld" do
      let(:record) { described_class.new(officer_name: "Name Withheld") }

      it { is_expected.to be_empty }
    end
  end

  describe "#given_names" do
    subject { record.given_names }

    context "when the record has one given name" do
      let(:record) { described_class.new(officer_name: "Doe, Jane") }

      it { is_expected.to eq(["Jane"]) }
    end

    context "when the record has multiple given names" do
      let(:record) { described_class.new(officer_name: "Doe, Jane Rodham") }

      it { is_expected.to eq(%w[Jane Rodham]) }
    end

    context "when the record has a suffix" do
      let(:record) { described_class.new(officer_name: "Doe, John JR") }

      it { is_expected.to eq(["John"]) }
    end

    context "when the officer's name is withheld" do
      let(:record) { described_class.new(officer_name: "Name Withheld") }

      it { is_expected.to be_empty }
    end
  end

  describe "#suffix" do
    subject { record.suffix }

    let(:record) { described_class.new(officer_name: officer_name) }

    context "when the name is not given" do
      let(:officer_name) { "Name Withheld" }

      it { is_expected.to be_blank }
    end

    context "when the suffix is SR" do
      let(:officer_name) { "Doe, Jon SR" }

      it { is_expected.to eq("SR") }
    end

    context "when the suffix is JR" do
      let(:officer_name) { "Doe, Jon JR" }

      it { is_expected.to eq("JR") }
    end

    context "when the suffix is JR." do
      let(:officer_name) { "Doe, Jon JR." }

      it { is_expected.to eq("JR.") }
    end

    context "when the suffix is JRS" do
      let(:officer_name) { "Doe, Jon JRS" }

      it { is_expected.to eq("JRS") }
    end

    context "when the suffix is II" do
      let(:officer_name) { "Doe, Jon II" }

      it { is_expected.to eq("II") }
    end

    context "when the suffix is III" do
      let(:officer_name) { "Doe, Jon III" }

      it { is_expected.to eq("III") }
    end

    context "when the suffix is IV" do
      let(:officer_name) { "Doe, Jon IV" }

      it { is_expected.to eq("IV") }
    end

    context "when the suffix is ESQ" do
      let(:officer_name) { "Doe, Jon ESQ" }

      it { is_expected.to eq("ESQ") }
    end

    context "when the suffix is MR" do
      let(:officer_name) { "Doe, Jon MR" }

      it { is_expected.to eq("MR") }
    end

    context "when the suffix is MRS" do
      let(:officer_name) { "Doe, Jon MRS" }

      it { is_expected.to eq("MRS") }
    end

    context "when the suffix is MS" do
      let(:officer_name) { "Doe, Jon MS" }

      it { is_expected.to eq("MS") }
    end
  end

  describe "#employment_start" do
    subject { record.employment_start }

    context "when a date is given" do
      let(:record) { described_class.new(employment_start_date: "11/5/2017") }

      it { is_expected.to eq(Date.parse("November 5, 2017")) }
    end

    context "when no date is given" do
      let(:record) { described_class.new(employment_start_date: "") }

      it { is_expected.to be_nil }
    end
  end

  describe "#employment_end" do
    subject { record.employment_end }

    context "when a date is given" do
      let(:record) { described_class.new(employment_end_date: "11/5/2017") }

      it { is_expected.to eq(Date.parse("November 5, 2017")) }
    end

    context "when no date is given" do
      let(:record) { described_class.new(employment_start_date: "") }

      it { is_expected.to be_nil }
    end
  end

  describe "#name_withheld?" do
    subject { described_class.new(officer_name: officer_name) }

    context "when the name is given" do
      let(:officer_name) { "Doe, Jane" }

      it { is_expected.not_to be_name_withheld }
    end

    context "when the name is not given" do
      let(:officer_name) { "Name Withheld" }

      it { is_expected.to be_name_withheld }
    end
  end

  describe "#ensure_agency" do
    subject { record.ensure_agency }

    let(:record) { described_class.new(agency: "Pinkerton") }

    context "when the agency does not exist" do
      it { is_expected.to be_an(Agency) }
      it { is_expected.to be_persisted }

      its(:name) { is_expected.to eq("Pinkerton") }
    end

    context "when the agency already exist" do
      let!(:existing_agency) do
        create :agency, name: "Pinkerton"
      end

      it { is_expected.to eq(existing_agency) }
    end
  end

  describe "#ensure_officer" do
    subject { record.ensure_officer }

    let(:record) do
      described_class.new(
        officer_name: "Jones, Jon Paul Simon JR.",
        post_id: "post123",
      )
    end

    context "when the officer did not exist" do
      it { is_expected.to be_an(Officer) }
      it { is_expected.to be_persisted }

      its(:first_name) { is_expected.to eq("Jon") }
      its(:last_name) { is_expected.to eq("Jones") }
      its(:middle_name) { is_expected.to eq("Paul Simon") }
      its(:suffix) { is_expected.to eq("JR.") }
      its(:post_id) { is_expected.to eq("post123") }
    end

    context "when the officer already exists" do
      let!(:existing_officer) do
        create :officer, post_id: "post123"
      end

      it { is_expected.to eq(existing_officer) }
    end
  end

  describe "#ensure_position" do
    subject(:position) { record.ensure_position }

    let!(:officer) { create :officer, post_id: "post123" }
    let!(:agency) { create :agency, name: "Pinkerton" }

    let(:record) do
      described_class.new(
        post_id: "post123",
        agency: "Pinkerton",
        employment_start_date: "05/04/2017",
        employment_end_date: "05/11/2018",
        rank: "DPTY",
      )
    end

    context "when the position did not exist" do
      it { is_expected.to be_a(Position) }
      it { is_expected.to be_persisted }

      its(:employment_start) { is_expected.to eq(Date.parse("May 4, 2017")) }
      its(:employment_end) { is_expected.to eq(Date.parse("May 11, 2018")) }
      its(:rank) { is_expected.to eq("DPTY") }

      it "assigns the right officer" do
        expect(position.officer).to eq(officer)
      end

      it "assigns the right agency" do
        expect(position.agency).to eq(agency)
      end
    end

    context "when the poistion already exists" do
      let!(:existing_position) do
        create :position,
          officer: officer,
          agency: agency,
          employment_start: Date.parse("May 4, 2017"),
          employment_end: Date.parse("May 11, 2018"),
          rank: "DPTY"
      end

      it { is_expected.to eq(existing_position) }
    end
  end
end
