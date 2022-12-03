class CartsController < ApplicationController
  #before_action :authenticate_user!, only: %i(index create show)
  before_action :current_cart
  before_action :load_product, only: %i(update create)

  def index; end

  def show; end

  def create
    if check_quantily @product
      add_cart @product, @quantily
    else
      flash[:danger] = t ".over_than_stock"
    end
    redirect_to request.referrer
  end

  def update
    if @carts.key? params[:id]
      update_cart
      store_location
    else
      flash[:danger] = t ".fail_update"
    end
    redirect_to request.referrer
  end

  def destroy
    if @carts.key? params[:id]
      delete_cart
    else
      flash[:danger] = t ".fail_delete"
    end
    redirect_to cart_path(id: 2)
  end

  private

  def load_product
    @product = Product.without_deleted.categorized.find_by id: params[:id]
    return if @product

    flash[:danger] = t ".no_product"
    redirect_to request.referer
  end

  def check_quantily product
    @quantily = params[:quantily].to_i
    @quantily >= 1 && @quantily <= product.quantity_in_stock
  end

  def add_cart product, quantily
    if @carts.key? product.id.to_s
      @carts[product.id.to_s] += quantily
    else
      @carts[product.id.to_s] = quantily
      user_id = session[:user_id]
      session["cart_#{user_id}"] = @carts
    end
    flash[:success] = t ".success_add_cart"
  end

  def update_cart
    if check_quantily @product
      @carts[params[:id]] = @quantily
      user_id = session[:user_id]
      session["cart_#{user_id}"] = @carts
      flash[:success] = t ".success_update"
    else
      flash[:danger] = t ".danger_quantily"
    end
  end

  def delete_cart
    @carts.delete params[:id]
    flash[:success] = t ".success_delete"
    user_id = session[:user_id]
    session["cart_#{user_id}"] = @carts
  end
end
