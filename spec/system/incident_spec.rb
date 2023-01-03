require 'rails_helper'

RSpec.describe "Incident" do
  before do
    create :officer, first_name: "Javert", last_name: "Valjean"
    driven_by(:rack_test)
    sign_in user
  end

  let(:user) { create :user }

  scenario "Manage incident" do
    visit incidents_path
    within 'main' do
      click_on "Add incident"
    end

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
    fill_in "Role", with: "Restrained victim"
    click_on "Add officer"

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
    click_on "Edit document"

    fill_in "Name", with: "Insta"
    fill_in "Description", with: "Photo of arrest"
    fill_in "Url", with: "https://example.com/insta"
    click_on "Update Document"

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

  scenario "Create incident" do
    visit root_path
    click_on "Add incident"
    fill_in "Heading", with: "Murder of Valentina"
    fill_in "Description", with: "Shot and killed in a coat store"
    click_on "Create Incident"

    expect(page).to have_current_path(incident_path(Incident.last))
    expect(page).to have_content("Murder of Valentina")
    expect(page).to have_content("Shot and killed in a coat store")
  end

  context "when an incident exists" do
    let(:incident) { create :incident }

    context "when the officer exists" do
      let(:jones) { create :officer, first_name: "Will", last_name: "Jones" }
      let(:lapd) { create :agency, short_name: "LAPD" }

      before { create :position, officer: jones, agency: lapd }

      scenario "Add existing officer" do
        visit incident_path(incident)
        click_on "Add officer"
        select "Will Jones (LAPD)", from: "Officer"
        fill_in "Role", with: "Shot Valentina with an M16"
        click_on "Add officer"

        expect(page).to have_current_path(incident_path(incident))
        expect(page).to have_content("Will Jones")
        expect(page).to have_content("Shot Valentina with an M16")
      end
    end

    scenario "Add new officer" do
      visit incident_path(incident)
      click_on "Add officer"
      select "New officer"
      fill_in "First name", with: "Javert"
      fill_in "Middle name", with: "Paul"
      fill_in "Last name", with: "Valjean"
      fill_in "Suffix", with: "Jr."
      fill_in "Role", with: "Shot Valentina with a musket"
      click_on "Add officer"

      expect(page).to have_current_path(incident_path(incident))
      expect(page).to have_content("Javert Paul Valjean Jr.")
      expect(page).to have_content("Shot Valentina with a musket")
    end
  end
end
