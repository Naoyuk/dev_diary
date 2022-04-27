# frozen_string_literal

class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[new create]
  before_action :published_post, only: %i[show]

  def index
    @posts = Post.published.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:publish]
      @post.published = true
    end
    if @post.save
      flash[:success] = 'New article was created!'
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if params[:publish]
      @post.published = true
    end
    if @post.update(post_params)
      flash[:success] = 'Post was updated!'
      redirect_to posts_url
    else
      render 'edit'
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :published)
    end

    def logged_in_user
      unless logged_in?
        store_url
        flash[:danger] = 'Please log in'
        redirect_to login_url
      end
    end

    def published_post
      post = Post.find_by(id: params[:id])
      if !is_published?(post)
        if !logged_in? || (post.user_id != current_user.id)
          flash[:danger] = 'Not found'
          redirect_to root_url
        end
      end
    end
end
