class ProfilesController < ApplicationController


  def show
    @user = User.find(params[:username])
  end

  def clean_user_parameters
    cookies[:name] = ""
    cookies[:email] = ""

    redirect_to request.referer
  end

end
