# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserEdits', type: :system do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
  end

  it 'requires to be logged in' do
    visit edit_user_path(@user)
    expect(render_template(login_url)).to be_truthy
    expect(page).to have_content 'Please log in'
    expect(page).not_to have_content 'Name'
    expect(page).not_to have_content 'Confirmation'
  end

  context 'correct user' do
    before do
      login_as(@user)
    end

    it 'is invalid with no informations' do
      visit edit_user_path(@user)
      expect(render_template(edit_user_url(@user))).to be_truthy
      fill_in 'Name', with: ''
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      fill_in 'Confirmation', with: ''
      click_button 'Save Changes'

      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Email can't be blank"
      expect(page).to have_content "Password can't be blank"
      expect(page).to have_content "Password confirmation can't be blank"
    end

    it 'is invalid with a too long name' do
      visit edit_user_path(@user)
      expect(render_template(edit_user_url(@user))).to be_truthy
      fill_in 'Name', with: 'a' * 51
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Confirmation', with: 'password'
      click_button 'Save Changes'

      expect(page).to have_content 'Name is too long (maximum is 50 characters)'
    end

    it 'is invalid with a too long email' do
      visit edit_user_path(@user)
      expect(render_template(edit_user_url(@user))).to be_truthy
      fill_in 'Name', with: 'test'
      fill_in 'Email', with: "#{'a' * 244}@example.com"
      fill_in 'Password', with: 'password'
      fill_in 'Confirmation', with: 'password'
      click_button 'Save Changes'

      expect(page).to have_content 'Email is too long (maximum is 255 characters)'
    end

    it 'is invalid with an invalid email address' do
      visit edit_user_path(@user)
      expect(render_template(edit_user_url(@user))).to be_truthy
      fill_in 'Name', with: 'test'
      fill_in 'Email', with: 'invalid@email@address.com'
      fill_in 'Password', with: 'password'
      fill_in 'Confirmation', with: 'password'
      click_button 'Save Changes'

      expect(page).to have_content 'Email is invalid'
    end

    it 'is invalid with differ between Password and Confirmation' do
      visit edit_user_path(@user)
      expect(render_template(edit_user_url(@user))).to be_truthy
      fill_in 'Name', with: 'test'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Confirmation', with: 'abcdef'
      click_button 'Save Changes'

      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    it 'is invalid with too short password' do
      visit edit_user_path(@user)
      expect(render_template(edit_user_url(@user))).to be_truthy
      fill_in 'Name', with: 'test'
      fill_in 'Email', with: 'test@example.com'
      fill_in 'Password', with: 'pass'
      fill_in 'Confirmation', with: 'pass'
      click_button 'Save Changes'

      expect(page).to have_content 'Password is too short (minimum is 6 characters)'
    end

    it 'is valid with correct informations' do
      visit edit_user_path(@user)
      expect(render_template(edit_user_url(@user))).to be_truthy
      name = 'new_name'
      email = 'new_email@example.com'
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: 'password'
      fill_in 'Confirmation', with: 'password'
      click_button 'Save Changes'

      expect(page).to have_content 'Your profile has updated!'
      expect(page).to have_content name
      @user.reload
      expect(@user.name).to eq name
      expect(@user.email).to eq email
    end
  end

  context 'other user' do
    it 'is invalid with correct informations' do
      visit edit_user_path(@user)
      expect(page).not_to have_content 'Welcome to the Dev Diary'
    end
  end

  scenario 'friendly forwarding when user tried to go profile page before logging in' do
    visit edit_user_url(@user)
    expect(render_template(login_url)).to be_truthy
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_content 'Update your profile'
  end
end
