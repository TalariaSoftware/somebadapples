require 'rails_helper'

RSpec.describe "Incident", type: :system do
  before do
    driven_by(:rack_test)
    sign_in user
  end

  let(:user) { create :user }
  let(:officer) { create :officer, first_name: "Javert", last_name: "Valjean" }

  scenario "Manage incident" do
    visit officer_path(officer)
    expect(page).to have_content("Javert Valjean")

    click_on "Add incident"

    fill_in "Heading", with: "Excessive force"
    fill_in "Description", with: "Beat driver"
    fill_in "Datetime", with: "2021-12-10 23:00"
    click_on "Create"

    expect(page).to have_content("Javert Valjean")

    expect(page).to have_content("Excessive force")
    expect(page).to have_content("Beat driver")
    expect(page).to have_content("December 10, 2021")

    click_on "Edit incident"

    fill_in "Heading", with: "Excessive violence"
    fill_in "Description", with: "Beat pedestrian"
    fill_in "Datetime", with: "2021-12-09 23:00"
    click_on "Update"

    expect(page).to have_content("Excessive violence")
    expect(page).to have_content("Beat pedestrian")
    expect(page).to have_content("December 09, 2021")

    click_on "Edit incident"
    click_on "Delete"

    expect(page).to have_content("Javert Valjean")
    expect(page).not_to have_content("Dec")
  end
end
