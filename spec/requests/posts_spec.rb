# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get posts_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success if the post has published' do
      @post = FactoryBot.create(:post, published: true)
      get post_path(@post)
      expect(response).to have_http_status(:success)
    end

    it 'returns http redirect if the post has not published' do
      @post = FactoryBot.create(:post, published: false)
      get post_path(@post)
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success if owner requests the post has not published' do
      post = FactoryBot.create(:post, published: false)
      user = post.user
      post login_path, params: { session: { email: user.email,
                                            password: user.password } }
      get post_path(post)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'redirect to log in page without logging in' do
      get new_post_path
      expect(response).to redirect_to login_url
    end

    it 'returns http success with logging in' do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'redirect to log in page without logging in' do
      post posts_path, params: { post: { title: 'new title',
                                         body: 'new article body' } }
      expect(response).to redirect_to login_url
    end

    it 'creates a new post post with logging in' do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      expect do
        post posts_path, params: { post: { title: 'new title',
                                           body: 'new article body' } }
      end.to change(Post, :count).by(1)
      expect(response).to redirect_to posts_url
    end
  end
end
