require 'rails_helper'

RSpec.describe "UserLogins", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "fails to log in with invalid informations" do
    name = "test"
    email = "test@example.com"
    password = "password"
    User.create(name: name, email: email, password: password,
                password_confirmation: password)

    visit login_path
    fill_in "Email", with: email
    fill_in "Password", with: "invalidpassword"
    click_button "Log in"
    
    expect(page).to have_content "Invalid email/password conbination"
    visit root_path
    expect(page).not_to have_content "Invalid email/password conbination"
  end

  it "shows log out button and doesn't show 'Log in' button when user logged in" do
    name = "test"
    email = "test@example.com"
    password = "password"
    User.create(name: name, email: email, password: password,
                password_confirmation: password)

    visit login_path
    fill_in "Email", with: email
    fill_in "Password", with: "password"
    click_button "Log in"

    expect(page).to have_content "Log out"
    expect(page).not_to have_content "Log in"
  end
end
