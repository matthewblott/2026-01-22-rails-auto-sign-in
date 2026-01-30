class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  before_action :authenticate

  private

  def authenticate
    unless @token.present? && @session_record && @user
      redirect_to sign_in_path
    end
  end

  def set_current_request_details
    @token = cookies.signed[:session_token]

    unless @token.present?
      return
    end

    @session_record = Session.find_by_id(@token)

    unless @session_record
      return
    end

    @user = User.find_by(id: @session_record.user_id)
    
    unless @user
      return
    end

    Current.user = @user
    Current.session = @session_record

  end

end
