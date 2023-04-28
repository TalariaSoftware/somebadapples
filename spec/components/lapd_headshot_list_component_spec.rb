require 'rails_helper'

RSpec.describe LapdHeadshotListComponent, type: :component do
  include Rails.application.routes.url_helpers

  subject(:component) { described_class.new lapd_headshots: [lapd_headshot] }

  let(:lapd_headshot) { build :lapd_headshot, file_name: 'pig.jpg' }

  before { render_inline component }

  it "includes the headshot" do
    expect(page).to have_css("img[src='/data/lapd_headshots/pig.jpg']")
  end

  it "includes the file name" do
    expect(page).to have_content("pig.jpg")
  end
end
