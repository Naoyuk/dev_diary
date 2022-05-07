# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostPublisheds', type: :system do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:other_user)
    @post_draft = FactoryBot.create(:post)
    @post_published = FactoryBot.create(:published_post)
  end

  context 'as a user not logged in' do
    it 'does not see posts that has not published yet' do
      visit posts_path
      expect(page).not_to have_content 'new title'
    end

    it 'sees posts that has published' do
      visit posts_path
      expect(page).to have_content 'published post'
    end
  end

  context 'as a user logged in but is not the owner of posts' do
    before do
      log_in_as @other_user
    end

    it 'does not see posts that has not published yet' do
      visit posts_path
      expect(page).not_to have_content 'new title'
    end

    it 'sees posts that has published' do
      visit posts_path
      expect(page).to have_content 'published post'
    end
  end

  context 'as the owner of posts' do
    before do
      log_in_as @user
    end

    it 'does not see posts that has not published yet' do
      visit posts_path
      expect(page).not_to have_content 'new title'
    end

    it 'sees posts that has published' do
      visit posts_path
      expect(page).to have_content 'published post'
    end
  end

  describe 'Buttons on post form page' do
    before do
      visit root_path
      click_on 'Log in'
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end

    scenario 'the owner sees Publish button and Save as draft button in form page when creating a post' do
      click_on 'New post'
      expect(page).to have_button 'Publish'
      expect(page).to have_button 'Save as draft'
    end

    scenario 'the owner sees Publish button and Save as draft button in form page when editing a post saved as draft' do
      click_on 'New post'
      fill_in 'post[title]', with: 'test title'
      fill_in 'post[body]', with: 'test title'
      click_button 'Save as draft'
      visit edit_post_path(Post.find_by(title: 'test title'))
      expect(page).to have_button 'Publish'
      expect(page).to have_button 'Update draft'
    end

    scenario 'the owner sees Update button in form page when editing a post published' do
      click_on 'New post'
      fill_in 'post[title]', with: 'test title'
      fill_in 'post[body]', with: 'test title'
      click_button 'Publish'
      visit edit_post_path(Post.find_by(title: 'test title'))
      expect(page).to have_button 'Update'
      expect(page).not_to have_button 'Publish'
      expect(page).not_to have_button 'Save as draft'
    end
  end
end
