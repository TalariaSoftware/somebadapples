require 'rails_helper'

RSpec.describe Officer, type: :model do
  it { is_expected.to have_many(:roles) }
  it { is_expected.to have_many(:incidents).through(:roles) }

  describe '#name' do
    subject(:name) { officer.name }

    let(:officer) do
      build :officer, first_name: first_name, middle_name: middle_name,
        last_name: last_name, suffix: suffix
    end
    let(:first_name) { "Jon" }
    let(:middle_name) { "Quincy" }
    let(:last_name) { "Public" }
    let(:suffix) { "Jr." }

    it { is_expected.to eq("Jon Quincy Public Jr.") }

    context "when there is no first name" do
      let(:first_name) { '' }

      it { is_expected.to eq("Quincy Public Jr.") }
    end

    context "when there is no middle name" do
      let(:middle_name) { '' }

      it { is_expected.to eq("Jon Public Jr.") }
    end

    context "when there is no last name" do
      let(:last_name) { '' }

      it { is_expected.to eq("Jon Quincy Jr.") }
    end

    context "when there is no suffix name" do
      let(:suffix) { '' }

      it { is_expected.to eq("Jon Quincy Public") }
    end
  end

  describe '#slug' do
    subject(:slug) do
      officer.valid?
      officer.slug
    end

    context "when there is a first and last name" do
      let(:officer) { build :officer, first_name: "Jon", last_name: "Doe" }

      it "is a combination of first and last name" do
        expect(slug).to eq("jon-doe")
      end
    end

    context "when there is only a first name" do
      let(:officer) { build :officer, first_name: "Jon", last_name: nil }

      it "is the first name" do
        expect(slug).to eq("jon")
      end
    end

    context "when there is only a last name" do
      let(:officer) { build :officer, first_name: nil, last_name: "Doe" }

      it "is the first name" do
        expect(slug).to eq("doe")
      end
    end
  end
end
