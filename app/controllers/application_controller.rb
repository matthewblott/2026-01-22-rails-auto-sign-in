class ApplicationController < ActionController::Base
  before_action :load_current_user
  before_action :authenticate_user!

  skip_before_action :authenticate_user!, only: []

  private

  def load_current_user
    token = cookies.encrypted[:device_token]
    return unless token

    if (user = User.find_by(device_token: token))
      Current.user = user
    end
  end

  def authenticate_user!
    return if Current.user

    redirect_to root_path
  end

end
