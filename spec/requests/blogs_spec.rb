require 'rails_helper'

RSpec.describe 'Blogs', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get blogs_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    before do
      @blog = FactoryBot.create(:blog)
    end

    it 'returns http success' do
      get blog_path(@blog)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'redirect to log in page without logging in' do
      get new_blog_path
      expect(response).to redirect_to login_url
    end

    it 'returns http success with logging in' do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      get new_blog_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'redirect to log in page without logging in' do
      post blogs_path, params: { blog: { title: 'new title',
                                        body: 'new article body' } }
      expect(response).to redirect_to login_url
    end

    it 'creates a new blog post with logging in' do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      expect {
        post blogs_path, params: { blog: { title: 'new title',
                                          body: 'new article body' } }
      }.to change(Blog, :count).by(1)
      expect(response).to redirect_to blogs_url
    end
  end
end
