# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostUserRelateds', type: :system do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    @post = @user.posts.create(title: 'post of user',
                               body: 'this is post of user')
    @other_post = @other_user.posts.create(title: 'post of other user',
                                           body: 'this is post of other_user')
  end

  scenario 'the post owner see only own posts' do
    login_as(@user)
    visit user_path(@user)
    expect(page).to have_content 'this is post of user'
    expect(page).not_to have_content 'this is post of other_user'
  end
end
