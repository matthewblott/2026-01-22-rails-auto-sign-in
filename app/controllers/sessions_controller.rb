class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[ create ]

  def create
    user = User.new
    user.password = 'password'
    user.save!
    @session = user.sessions.create!
    cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }
    redirect_to root_path
  end

  def destroy
    Current.session.destroy
    cookies.delete(:session_token)
    reset_session

    # Normally undisirable but probably not for this application
    Current.user.destroy

    redirect_to sign_in_path 
  end

end
