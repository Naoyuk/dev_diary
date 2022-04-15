# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /new' do
    it 'returns http success' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'log in and redirect to profile page' do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }

      expect(response).to redirect_to user_path(@user)
      expect(is_logged_in?).to be_truthy
    end
  end

  describe 'DELETE /logout' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'log out and redirect to root path' do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }

      expect(response).to redirect_to user_path(@user)
      expect(is_logged_in?).to be_truthy

      delete logout_path

      expect(response).to redirect_to root_path
      expect(is_logged_in?).not_to be_truthy
    end
  end
end
