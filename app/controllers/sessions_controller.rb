class SessionsController < ApplicationController
  before_action :require_no_user!, only: %i(create new)

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user.nil?
      render :new
    else
      log_in!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end
end