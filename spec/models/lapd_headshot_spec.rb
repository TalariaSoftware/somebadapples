require 'rails_helper'

RSpec.describe LapdHeadshot do
  subject(:headshot) do
    build :lapd_headshot, file_name: 'MOORE MICHEL, R - # 23506.jpg'
  end

  it { is_expected.to validate_presence_of(:file_name) }
  it { is_expected.to validate_uniqueness_of(:file_name) }

  describe '#file_path' do
    subject(:file_path) { headshot.file_path }

    let(:expected_path) do
      '/data/lapd_headshots/MOORE%20MICHEL,%20R%20-%20%23%2023506.jpg'
    end

    it { is_expected.to eq(expected_path) }
  end

  describe '#officer_name' do
    subject(:officer_name) { headshot.officer_name }

    it { is_expected.to eq('MOORE MICHEL, R') }
  end

  describe '#serial_number' do
    subject(:serial_number) { headshot.serial_number }

    it { is_expected.to eq('23506') }
  end
end
