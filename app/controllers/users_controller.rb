# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update]
  before_action :correct_user, only: %i[edit update]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @entries = current_user.entry.page params[:page] if logged_in?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:info] = 'Welcome to DevDiary!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Your profile has updated!'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :time_zone)
  end

  def logged_in_user
    return if logged_in?

    store_url
    flash[:danger] = 'Please log in'
    redirect_to login_url
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(login_url) unless @user == current_user
  end
end
