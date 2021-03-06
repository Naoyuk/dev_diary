# frozen_string_literal: true

module LoginHelper
  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user, remember_me: '1')
    post login_path, params: { session: {
      email: user.email,
      password: user.password,
      remember_me:
    } }
  end
end

RSpec.configure do |config|
  config.include LoginHelper
end
