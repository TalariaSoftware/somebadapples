require 'rails_helper'

RSpec.describe Officer, type: :model do
  it { is_expected.to have_many(:incidents) }

  describe '#name' do
    subject(:name) { officer.name }

    context "when there is a first and last name" do
      let(:officer) { build :officer, first_name: "Jon", last_name: "Doe" }

      it "is a combination of first and last name" do
        expect(name).to eq("Jon Doe")
      end
    end

    context "when there is only a first name" do
      let(:officer) { build :officer, first_name: "Jon", last_name: nil }

      it "is the first name" do
        expect(name).to eq("Jon")
      end
    end

    context "when there is only a last name" do
      let(:officer) { build :officer, first_name: nil, last_name: "Doe" }

      it "is the first name" do
        expect(name).to eq("Doe")
      end
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
