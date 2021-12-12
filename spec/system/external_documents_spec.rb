require 'rails_helper'

RSpec.describe "External Document", type: :system do
  before do
    driven_by(:rack_test)
    create :incident, officer: officer, description: 'Wrongful arrest'
    sign_in user
  end

  let(:user) { create :user }
  let(:officer) { create :officer, first_name: "Javert", last_name: "Valjean" }

  scenario "Manage external_document" do
    visit officer_path(officer)
    expect(page).to have_content("Javert Valjean")
    expect(page).to have_content("Wrongful arrest")

    click_on "Add external document"

    fill_in "Name", with: "Tweet"
    fill_in "Description", with: "Video of arrest"
    fill_in "Url", with: "https://example.com/tweet"
    click_on "Create"

    expect(page).to have_content("Javert Valjean")
    expect(page).to have_content("Wrongful arrest")
    expect(page).to have_content("Video of arrest")
    expect(page).to have_link(href: "https://example.com/tweet")

    click_on "Edit external document"

    fill_in "Name", with: "Insta"
    fill_in "Description", with: "Photo of arrest"
    fill_in "Url", with: "https://example.com/insta"
    click_on "Update External document"

    expect(page).to have_content("Photo of arrest")
    expect(page).to have_link(href: "https://example.com/insta")

    click_on "Edit external document"
    click_on "Delete"

    expect(page).to have_content("Javert Valjean")
    expect(page).not_to have_content("Photo")
  end
end
