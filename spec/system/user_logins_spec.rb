require 'rails_helper'

RSpec.describe "UserLogins", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "fails loggin in with invalid informations" do
    FactoryBot.create(:user)
    visit login_path
    fill_in "Email", with: "tester1@example.com"
    fill_in "Password", with: "invalidpassword"
    click_button "Log in"
    
    expect(page).to have_content "Invalid email/password conbination"
    visit root_path
    expect(page).not_to have_content "Invalid email/password conbination"
  end
end
