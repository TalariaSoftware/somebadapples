require 'rails_helper'

RSpec.describe Document, type: :model do
  it { is_expected.to belong_to(:incident) }

  describe '#youtube?' do
    subject(:document) { build :document, url: url }

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

    context 'when the URL is invalid' do
      let(:url) { 'this is not a url' }

      it { is_expected.not_to be_youtube }
    end
  end

  describe '#youtube_id' do
    subject(:youtube_id) { document.youtube_id }

    let(:document) { build :document, url: url }

    context 'when the host is not a YouTube domain' do
      let(:url) { 'https://www.myspace.com/youtube.com?v=foobar' }

      it { is_expected.to be_nil }
    end

    context 'when the URL points to a video on YouTube' do
      let(:url) { 'https://youtube.com/watch?v=videoID' }

      it { is_expected.to eq('videoID') }
    end

    context 'when the URL does NOT point to a video on YouTube' do
      let(:url) { 'https://www.youtube.com/feed/explore' }

      it { is_expected.to be_blank }
    end
  end

  describe '#youtube_embed_src' do
    subject(:youtube_embed_src) { document.youtube_embed_src }

    let(:document) { build :document, url: url }

    context 'when the URL does NOT point to a video on YouTube' do
      let(:url) { 'https://www.youtube.com/feed/explore' }

      it { is_expected.to be_blank }
    end

    context 'when the URL points to a video on YouTube' do
      let(:url) { 'https://youtube.com/watch?v=videoID' }

      it { is_expected.to eq('https://www.youtube-nocookie.com/embed/videoID') }
    end
  end
end
