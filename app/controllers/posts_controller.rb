# frozen_string_literal

class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[new create]

  def index
    @posts = Post.all.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'New article was created!'
      redirect_to posts_url
    else
      render 'new'
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body)
    end

    def logged_in_user
      unless logged_in?
        store_url
        flash[:danger] = 'Please log in'
        redirect_to login_url
      end
    end
end
