class ExternalDocument < ApplicationRecord
  belongs_to :incident

  def youtube?
    domain = PublicSuffix.domain(URI.parse(url).host)
    domain.in? ['youtube.com', 'youtu.be']
  rescue URI::InvalidURIError
    false
  end
end
