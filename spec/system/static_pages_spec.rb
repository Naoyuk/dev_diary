# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario 'you can visit home page' do
    visit root_path

    expect(page).to have_title full_title('Home')
    expect(page).to have_content 'Welcome to the Dev Diary'
  end

  scenario 'you can visit about page' do
    visit static_pages_about_path

    expect(page).to have_title full_title('About')
    expect(page).to have_content 'このWebサイトでは、主にアプリケーションの開発日誌を書き留めていきます。'
  end

  scenario 'can jump to about page from home' do
    visit static_pages_home_path

    click_link 'About'
    expect(page).to have_title full_title('About')
  end

  scenario 'can jump to home page from about' do
    visit static_pages_about_path

    click_link 'Home'
    expect(page).to have_title full_title('Home')
  end
end
