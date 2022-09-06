class SessionsController < ApplicationController
  before_action :find_by_email, only: %i(create)

  def new
    @user = User.new
  end

  def create
    if @user&.authenticate params[:session][:password]
      check_activated_user
    else
      flash.now[:danger] = t ".user_not_found"
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def find_by_email
    @user = User.find_by email: params[:session][:email].downcase
    return if @user

    flash[:danger] = t ".user_not_found"
    redirect_to signup_path
  end

  def check_activated_user
    if @user.activated?
      log_in @user
      remember @user
      if @user.Admin?
        redirect_to admin_static_pages_path
      else
        redirect_to root_path
      end
    else
      flash[:warning] = t ".account_not_activated"
      redirect_to root_path
    end
  end
end
