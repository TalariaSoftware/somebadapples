require 'rails_helper'

RSpec.describe "Authentication", type: :system do
  before do
    driven_by(:rack_test)
    User.create! email: 'user@example.com', password: 'password'
  end

  scenario "Allows users to sign in and out" do
    visit '/'

    click_on "Sign in"
    fill_in "Email", with: 'user@example.com'
    fill_in "Password", with: 'password'
    click_on "Log in"

    expect(page).to have_text("Signed in as user@example.com")

    click_on "Sign out"
    expect(page).not_to have_text("user@example.com")
  end
end
