class Admin::BaseController < ApplicationController
  include SessionsHelper
  layout "layouts/application_admin"

  before_action :logged_in_admin

  private
  def logged_in_admin
    if !current_user&.Admin?
      flash[:danger] = t("carts.show.please_login_admin")
      redirect_to root_path
    end
  end
end
