require 'rails_helper'

RSpec.describe "Component Previews" do
  before { driven_by(:rack_test) }

  ViewComponent::Preview.all.each do |preview|
    scenario "Visit #{preview} preview and examples" do
      visit preview_view_components_path
      within '.sidenav' do
        click_on preview.preview_name.titleize
      end

      expect(page).to have_content(preview.preview_name.camelize)

      preview.examples.each do |sample|
        within '.sidenav' do
          click_on sample
        end
      end
    end
  end
end
