require 'rails_helper'

RSpec.describe FlashHashComponent, type: :component do
  include Rails.application.routes.url_helpers

  subject(:component) { described_class.new flash_hash: flash_hash }

  let(:flash_hash) { { "notice" => "look" } }

  def render_component
    render_inline(component)
  end

  it "includes the content" do
    render_component
    expect(page.find('p.usa-alert__text')).to have_content("look")
  end

  context "when the flash is a notice" do
    let(:flash_hash) { { "notice" => "look" } }

    it "is an success alert" do
      render_component
      expect(page).to have_css('.usa-alert.usa-alert--success')
    end
  end

  context "when the flash is an alert" do
    let(:flash_hash) { { "alert" => "look" } }

    it "is an error alert" do
      render_component
      expect(page).to have_css('.usa-alert.usa-alert--error')
    end
  end

  context "when there are multiple flashes" do
    let(:flash_hash) do
      {
        notice: "look",
        warning: "duck",
      }
    end

    it "includes the content for first flashes" do
      render_component
      expect(page.find_all('p.usa-alert__text').first).to have_content("look")
    end

    it "includes the content for flashes" do
      render_component
      expect(page.find_all('p.usa-alert__text').last).to have_content("duck")
    end
  end
end
