class Document < ApplicationRecord
  extend Pagy::Searchkick
  searchkick

  belongs_to :incident

  def youtube?
    domain = PublicSuffix.domain(URI.parse(url).host)
    domain.in? ['youtube.com', 'youtu.be']
  rescue URI::InvalidURIError
    false
  end

  def youtube_id
    return nil unless youtube?

    query = URI.parse(url).query
    return nil if query.blank?

    CGI.parse(query)['v'].first
  end

  def youtube_embed_src
    return if youtube_id.blank?

    "https://www.youtube-nocookie.com/embed/#{youtube_id}"
  end
end
