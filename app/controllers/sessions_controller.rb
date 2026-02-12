class SessionsController < ApplicationController
  before_action :require_user, only: :destroy

  skip_before_action :authenticate_user!, only: :create

  def create
    return redirect_to start_path if Current.user

    user = User.create!

    cookies.permanent.encrypted[:device_token] = {
      value: user.device_token,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax
    }

    Current.user = user

    redirect_to root_path
  end

  def destroy
    Current.user&.destroy
    cookies.delete(:device_token)
    redirect_to sign_in_path 
  end

  private

  def require_user
    redirect_to root_path unless Current.user
  end

end
