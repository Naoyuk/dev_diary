# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_origin_or user
    else
      flash.now[:danger] = 'Invalid email/password conbination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
