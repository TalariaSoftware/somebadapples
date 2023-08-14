require 'rails_helper'

RSpec.describe Us::Ca::PostRoster2022::Entry do
  subject { build :'us/ca/post_roster2022_entry' }

  it { is_expected.to validate_presence_of(:officer_id) }
  it { is_expected.to validate_presence_of(:officer_name) }
  it { is_expected.to validate_presence_of(:post_id) }
  it { is_expected.to validate_presence_of(:agency) }
  it { is_expected.to validate_presence_of(:employment_start_date) }
  it { is_expected.to validate_presence_of(:rank) }

  it { is_expected.to validate_uniqueness_of(:officer_id) }

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

    context "when the officer's name is nil" do
      let(:record) { described_class.new(officer_name: nil) }

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

  describe "#post_id_withheld?" do
    subject { described_class.new(post_id: post_id) }

    context "when the POST ID is given" do
      let(:post_id) { "A12-BCD" }

      it { is_expected.not_to be_post_id_withheld }
    end

    context "when the POST ID is not given" do
      let(:post_id) { "POST ID Withheld" }

      it { is_expected.to be_post_id_withheld }
    end
  end

  describe ".import" do
    let(:input_file) do
      Tempfile.create.tap do |file|
        file.write <<~CSV
          officer_id,officer_name,post_id,agency,employment_start_date,employment_end_date,rank
          1,"DOE, JON",A12-B34,ARCADIA PD,11/13/2017,05/20/2018,PO
        CSV

        file.close
      end
    end

    after { File.unlink input_file }

    it do
      expect {
        described_class.import input_file
      }.to change(described_class, :count).by(1)
    end

    describe "new entry" do
      subject(:new_entry) do
        described_class.import input_file
        described_class.last
      end

      specify { expect(new_entry.officer_id).to eq(1) }
      specify { expect(new_entry.officer_name).to eq("DOE, JON") }
      specify { expect(new_entry.post_id).to eq("A12-B34") }
      specify { expect(new_entry.agency).to eq("ARCADIA PD") }
      specify { expect(new_entry.employment_start_date).to eq(Date.parse("2017-11-13")) }
      specify { expect(new_entry.employment_end_date).to eq(Date.parse("2018-05-20")) }
      specify { expect(new_entry.rank).to eq("PO") }
    end
  end
end
