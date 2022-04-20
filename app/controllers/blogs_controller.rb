class BlogsController < ApplicationController
  before_action :logged_in_user, only: %i[new create]

  def index
    @blogs = Blog.all.page(params[:page])
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:success] = 'New article was created!'
      redirect_to blogs_url
    else
      render 'new'
    end
  end

  private

    def blog_params
      params.require(:blog).permit(:title, :body)
    end

    def logged_in_user
      unless logged_in?
        store_url
        flash[:danger] = 'Please log in'
        redirect_to login_url
      end
    end
end
