class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(update)
  before_action :find_user, except: %i(new create)
  before_action :correct_user, only: %i(update)

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_mail_activate
      flash[:info] = t ".mail_notice"
      redirect_to root_path
    else
      flash.now[:danger] = t ".users_unsuccess"
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    end
  end

  def destroy; end

  def update
    if @user.update user_params_update
      flash[:success] = t ".edit_success"
      redirect_to edit_user_path current_user
    else
      flash[:danger] = t ".edit_fail"
      render :edit
    end
  end

  private
  def user_params_update
    params.require(:user).permit User::USER_UPDATE
  end

  def user_params
    params.require(:user).permit User::USER_ATTRIBUTES
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t("users.before_action.not_found")
    redirect_to root_path
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t "users.before_action.not_correct"
    redirect_to root_path
  end
end
