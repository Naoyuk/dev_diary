require 'rails_helper'

RSpec.describe "UserSignups", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "is invalid with no informations" do
    visit signup_path
    fill_in "Name", with: ""
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Confirmation", with: ""
    click_button "Save Change"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
    expect(page).to have_content "Password confirmation can't be blank"
  end

  it "is invalid with too long name" do
    visit signup_path
    fill_in "Name", with: "a" * 51
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Confirmation", with: "password"
    click_button "Save Change"

    expect(page).to have_content "Name is too long (maximum is 50 characters)"
  end

  it "is invalid with too long email" do
    visit signup_path
    fill_in "Name", with: "test"
    fill_in "Email", with: "a" * 244 + "@example.com"
    fill_in "Password", with: "password"
    fill_in "Confirmation", with: "password"
    click_button "Save Change"

    expect(page).to have_content "Email is too long (maximum is 255 characters)"
  end

  it "is invalid with invalid email address" do
    visit signup_path
    fill_in "Name", with: "test"
    fill_in "Email", with: "invalid@email@address.com"
    fill_in "Password", with: "password"
    fill_in "Confirmation", with: "password"
    click_button "Save Change"

    expect(page).to have_content "Email is invalid"
  end

  it "is invalid with differ between Password and Confirmation" do
    visit signup_path
    fill_in "Name", with: "test"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "password"
    fill_in "Confirmation", with: "abcdef"
    click_button "Save Change"

    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it "is invalid with too short password" do
    visit signup_path
    fill_in "Name", with: "test"
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "pass"
    fill_in "Confirmation", with: "pass"
    click_button "Save Change"

    expect(page).to have_content "Password is too short (minimum is 6 characters)"
  end

  # it "is valid with correct informations" do
  #   visit signup_path
  #   fill_in "Name", with: "test"
  #   fill_in "Email", with: "test@example.com"
  #   fill_in "Password", with: "password"
  #   fill_in "Confirmation", with: "password"
  #   click_button "Save Change"

  #   expect(page).to have_content "Welcome to DevDiary!"
  # end

end
