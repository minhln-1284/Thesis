class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  include CartsHelper
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :current_cart, :load_product_in_cart, :search_bar
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def search_bar
    @q = Product.ransack(params[:q])
  end

  def configure_permitted_parameters
    added_attrs = %i(name phone)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone])
  end

  def after_sign_in_path_for resource
    if current_user.Admin?
      (stored_location_for(resource) || admin_root_path)
    else
      (stored_location_for(resource) || root_path)
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t("users.before_action.not_found")
    redirect_to root_path
  end
end
