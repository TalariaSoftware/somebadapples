require 'rails_helper'

RSpec.describe ExternalDocument, type: :model do
  it { is_expected.to belong_to(:incident) }

  describe '#youtube?' do
    subject(:document) { build :external_document, url: url }

    context 'when the host is not a YouTube domain' do
      let(:url) { 'https://www.myspace.com/youtube.com' }

      it { is_expected.not_to be_youtube }
    end

    context 'when the host is youtube.com' do
      let(:url) { 'https://youtube.com/watch?v=6SFNW5F8K9Y' }

      it { is_expected.to be_youtube }
    end

    context 'when the host is youtu.be' do
      let(:url) { 'https://youtu.be/watch?v=6SFNW5F8K9Y' }

      it { is_expected.to be_youtube }
    end
  end
end
