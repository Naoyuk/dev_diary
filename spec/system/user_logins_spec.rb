# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserLogins', type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'fails to log in with invalid informations' do
    name = 'test'
    email = 'test@example.com'
    password = 'password'
    User.create(name:, email:, password:,
                password_confirmation: password)

    visit login_path
    fill_in 'Email', with: email
    fill_in 'Password', with: 'invalidpassword'
    click_button 'Log in'

    expect(page).to have_content 'Invalid email/password conbination'
    visit root_path
    expect(page).not_to have_content 'Invalid email/password conbination'
  end

  it "shows log out button and doesn't show 'Log in' button when user logged in" do
    name = 'test'
    email = 'test@example.com'
    password = 'password'
    User.create(name:, email:, password:,
                password_confirmation: password)

    visit login_path
    fill_in 'Email', with: email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content 'Log out'
    expect(page).not_to have_content 'Log in'
  end

  describe 'Remember me check box' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'when user checks the Remember me checkbox' do
      it 'stores the remember_token in the cookie' do
        log_in_as(@user)
        expect(cookies[:remember_token]).not_to eq nil
      end
    end

    context "when user doesn't check the Remember me checkbox" do
      it "doesn't store the remember_token in the cookies" do
        log_in_as(@user, remember_me: '0')
        expect(cookies[:remember_token]).to eq nil
      end
    end
  end
end
