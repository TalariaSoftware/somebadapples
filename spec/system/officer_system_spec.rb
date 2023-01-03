require 'rails_helper'

RSpec.describe "Officers" do
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
    fill_in "Middle name", with: "Paul"
    fill_in "Last name", with: "Valjean"
    fill_in "Suffix", with: "Jr."
    click_on "Create"

    visit officers_path
    expect(page).to have_content("Officers")

    expect(page).to have_content "Javert Paul Valjean Jr."
    click_on "Valjean"

    expect(page).to have_content("Javert Paul Valjean Jr.")

    click_on "Edit"

    fill_in "First name", with: "Allan"
    fill_in "Middle name", with: "Jay"
    fill_in "Last name", with: "Pinkerton"
    fill_in "Suffix", with: "Sr."
    click_on "Update"

    expect(page).to have_content("Allan Jay Pinkerton Sr.")

    visit officers_path
    expect(page).to have_content("Officers")

    click_on "Pinkerton"
    click_on "Edit"
    click_on "Delete"

    expect(page).to have_content("Officers")
    expect(page).not_to have_content("Pinkerton")
  end
end
