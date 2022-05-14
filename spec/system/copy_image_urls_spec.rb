require 'rails_helper'

RSpec.describe 'CopyImageUrls', js: true, type: :system do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user)
    @picture = FactoryBot.create(:picture)
  end

  scenario 'copy image url to clipboard' do
    pending('something is wrong with evaluate_async_script')
    visit root_path
    click_link 'Log in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    visit pictures_path
    image_url = page.find('.select-picture')['src']
    pos_last_slash = image_url.rindex('/') + 1
    alt = image_url[pos_last_slash..]
    markdown_image_url = '![' + alt + '](' + image_url + ')'
    find('.select-picture').click
    
    clip_text = page.evaluate_async_script('navigator.clipboard.readText().then(arguments[0])')
    expect(clip_text).to eq markdown_image_url
  end

end
