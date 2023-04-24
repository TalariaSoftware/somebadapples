require 'rails_helper'

RSpec.describe LapdHeadshotComponent, type: :component do
  include Rails.application.routes.url_helpers

  subject(:component) { described_class.new lapd_headshot: lapd_headshot }

  let(:lapd_headshot) { build :lapd_headshot, file_name: 'pig.jpg' }

  def render_component
    render_inline(component)
  end

  it "includes the headshot" do
    render_component
    expect(page).to have_css("img[src='/data/lapd_headshots/pig.jpg']")
  end

  it "includes the file name" do
    render_component
    expect(page).to have_content("pig.jpg")
  end
end
