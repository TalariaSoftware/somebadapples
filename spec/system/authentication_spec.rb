require 'rails_helper'

RSpec.describe "Authentication" do
  before do
    driven_by(:rack_test)
    create :user, email: 'user@example.com', password: 'password'
  end

  scenario "Allows users to sign in and out" do
    visit '/'

    click_on "Sign in"
    fill_in "Email", with: 'user@example.com'
    fill_in "Password", with: 'password'
    click_on "Sign in"

    expect(page).to have_text("user@example.com")

    click_on "Sign out"
    expect(page).not_to have_text("user@example.com")
  end
end
