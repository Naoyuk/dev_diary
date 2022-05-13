# frozen_string_literal: true

class PicturesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in_user, only: %i[index new create]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to pictures_url
    else
      render 'new'
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:photo)
  end

  def logged_in_user
    return if logged_in?

    store_url
    flash[:danger] = 'Please log in'
    redirect_to login_url
  end
end
