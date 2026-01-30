class SecretsController < ApplicationController
  skip_before_action :authenticate, only: %i[ create ]
  before_action :set_session, only: :destroy

  def create
    # user = User.find_by(email: params[:email])

    if user&.valid_otp?(params[:otp_code])
      @session = user.sessions.create!

      if Rails.env.test?
        cookies[:session_token] = @session.id
      else
        cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }
      end

      Current.session = @session
      Current.user = user

      # The authenticated event is to be sent to Android client
      # redirect_to sign_in_success_path(user_id: user.id)
    end
  end

  def destroy
    @session.destroy
  end

  private

  def set_session
    session_id = cookies.signed[:session_token] || cookies[:session_token]
    return unless session_id

    @session = Session.find_by(id: session_id)
    Current.session = @session
    Current.user = @session&.user
  end

end
