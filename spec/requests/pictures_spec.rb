# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pictures', type: :request do
  describe 'GET /index' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'redirect to log in page without logging in' do
      get new_picture_path
      expect(response).to redirect_to login_url
    end

    it 'returns http success if logged in' do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      get pictures_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'redirect to log in page without logging in' do
      get new_picture_path
      expect(response).to redirect_to login_url
    end

    it 'returns http success with logging in' do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      get new_picture_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    before do
      @user = FactoryBot.create(:user)
      @params = { picture: { photo: fixture_file_upload(
                  File.join(Rails.root, 'spec/fixtures/test.jpeg'),
                                        'image/jpeg') } }
    end

    it 'redirect to log in page without logging in' do
      post pictures_path, params: @params
      expect(response).to redirect_to login_url
    end

    it 'creates a new post post with logging in' do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      expect do
        post pictures_path, params: @params
      end.to change(Picture, :count).by(1)
      expect(response).to redirect_to pictures_url
    end
  end
end
