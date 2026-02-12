class StaticPagesController < ApplicationController

  def splash

    if Current.user
      redirect_to home_path
    else
      redirect_to sign_in_path
    end
  end

end
