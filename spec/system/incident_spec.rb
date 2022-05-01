require 'rails_helper'

RSpec.describe "Incident", type: :system do
  before do
    create :officer, first_name: "Javert", last_name: "Valjean"
    driven_by(:rack_test)
    sign_in user
  end

  let(:user) { create :user }

  scenario "Manage incident" do
    visit incidents_path
    click_on "Add incident"

    fill_in "Heading", with: "Excessive force"
    fill_in "Description", with: "Beat driver"
    fill_in "Datetime", with: "2021-12-10 23:00"
    click_on "Create"

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
    click_on "Add officer"

    select "Javert Valjean", from: "Officer"
    fill_in "Description", with: "Restrained victim"
    click_on "Create Incident role"

    expect(page).to have_content("Excessive violence")
    expect(page).to have_content("Beat pedestrian")
    expect(page).to have_content("December 09, 2021")
    expect(page).to have_content("Javert Valjean")
    expect(page).to have_content("Restrained victim")

    click_on "Edit incident"
    click_on "Add document"

    fill_in "Name", with: "Tweet"
    fill_in "Description", with: "Video of arrest"
    fill_in "Url", with: "https://example.com/tweet"
    click_on "Create"

    expect(page).to have_content("Excessive violence")
    expect(page).to have_content("Beat pedestrian")
    expect(page).to have_content("December 09, 2021")
    expect(page).to have_content("Javert Valjean")
    expect(page).to have_content("Restrained victim")
    expect(page).to have_content("Video of arrest")
    expect(page).to have_link(href: "https://example.com/tweet")

    click_on "Edit incident"
    click_on "Edit external document"

    fill_in "Name", with: "Insta"
    fill_in "Description", with: "Photo of arrest"
    fill_in "Url", with: "https://example.com/insta"
    click_on "Update External document"

    expect(page).to have_content("Photo of arrest")
    expect(page).to have_link(href: "https://example.com/insta")

    expect(page).to have_content("Excessive violence")
    expect(page).to have_content("Beat pedestrian")
    expect(page).to have_content("December 09, 2021")
    expect(page).to have_content("Javert Valjean")
    expect(page).to have_content("Restrained victim")
    expect(page).to have_content("Photo of arrest")
    expect(page).to have_link(href: "https://example.com/insta")

    click_on "Edit incident"
    click_on "Delete"

    expect(page).not_to have_content("Excessive violence")
  end
end
