require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "you can visit home page" do
    visit root_path

    expect(page).to have_title "Home | DevDiary"
    expect(page).to have_content "Find me in app/views/static_pages/home.html.erb"
  end

  scenario "you can visit about page" do
    visit static_pages_about_path

    expect(page).to have_title "About | DevDiary"
    expect(page).to have_content "このWebサイトでは、主にアプリケーションの開発日誌を書き留めていきます。"
  end
end
