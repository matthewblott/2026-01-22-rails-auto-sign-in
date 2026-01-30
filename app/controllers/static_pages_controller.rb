class StaticPagesController < ApplicationController
  skip_before_action :authenticate, only: %i[ about home sign_in splash ]

  def splash
    if Current.user
      redirect_to home_path
    else
      redirect_to sign_in_path
    end
  end

end
