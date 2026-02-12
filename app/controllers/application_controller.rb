class ApplicationController < ActionController::Base
  before_action :load_current_user

  private

  def load_current_user
    token = cookies.encrypted[:device_token]
    return unless token

    if (user = User.find_by(device_token: token))
      Current.user = user
    end
  end

end
