# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /signup' do
    it 'returns http success' do
      get '/signup'
      expect(response).to have_http_status(:success)
    end

    it 'redirects to log in page when user is not logged in' do
      get users_path
      expect(response).to redirect_to login_url
    end
  end
end
