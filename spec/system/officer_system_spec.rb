require 'rails_helper'

RSpec.describe "Officers", type: :system do
  before do
    driven_by(:rack_test)
    sign_in user
  end

  let(:user) { create :user }

  scenario "Manage officers" do
    visit officers_path
    expect(page).to have_content("Officers")

    click_on "Add officer"

    fill_in "First name", with: "Javert"
    fill_in "Last name", with: "Valjean"
    fill_in "Badge number", with: "dozen"
    fill_in "Serial number", with: "cocoapuff"
    click_on "Create"

    visit officers_path
    expect(page).to have_content("Officers")

    expect(page).to have_content "Javert Valjean"
    click_on "Javert Valjean"

    expect(page).to have_content("Javert Valjean")
    expect(page).to have_content("dozen")
    expect(page).to have_content("cocoapuff")

    click_on "Edit"

    fill_in "First name", with: "Allan"
    fill_in "Last name", with: "Pinkerton"
    fill_in "Badge number", with: "12"
    fill_in "Serial number", with: "23"
    click_on "Update"

    expect(page).to have_content("Allan Pinkerton")
    expect(page).to have_content("12")
    expect(page).to have_content("23")

    visit officers_path
    expect(page).to have_content("Officers")

    click_on "Allan Pinkerton"
    click_on "Edit"
    click_on "Delete"

    expect(page).to have_content("Officers")
    expect(page).not_to have_content("Pinkerton")
  end
end
