class PicturesController < ApplicationController
  skip_before_action :verify_authenticity_token

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
end