require 'rails_helper'

RSpec.describe LapdHeadshotComponent, type: :component do
  include Rails.application.routes.url_helpers

  subject(:component) { described_class.new lapd_headshot: lapd_headshot }

  let(:lapd_headshot) do
    build :'us/ca/los_angeles/police/headshots20230321_headshot',
      file_name: 'pig.jpg'
  end

  def render_component
    render_inline(component)
  end

  it "includes the headshot" do
    render_component
    expect(page).to have_css(
      "img[src='/data/us/ca/police/los_angeles/headshots_20230321/pig.jpg']",
    )
  end

  it "includes the file name" do
    render_component
    expect(page).to have_content("pig.jpg")
  end
end
