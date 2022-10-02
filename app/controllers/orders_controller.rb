class OrdersController < ApplicationController
  #before_action :authenticate_user!, only: %i(new create)
  before_action :current_cart, :load_product_in_cart
  before_action :check_product_quantity, only: %i(new create)

  def index
    @pagy, @orders = pagy current_user.orders
  end

  def new
    binding.pry
    if current_user.nil?
      @order = Order.new
    else
      @order = current_user.orders.build
    end
    @product = Product.find_by id: params[:id]
  end

  def create
    binding.pry
    if current_user.nil?
      @order = Order.new order_params
      @order.user_id = 1
    else
      @order = current_user.orders.new order_params
    end
    #@order = current_user.orders.new order_params
    if @order.valid?
      create_transaction
    else
      flash.now[:danger] = t ".order_fail"
      render :new
    end
  end

  def destroy
    @order = Order.find params[:id]
    if @order.destroy
      flash[:success] = t "static_pages.delete_success"
      redirect_to action: :index
    else
      flash[:danger] = t "static_pages.delete_fail"
    end
  end

  def change
    @order = Order.find_by(id: params[:id]).Canceled!
    if @order
      flash[:success] = t "static_pages.change_success"
    else
      flash[:danger] = t "static_pages.change_fail"
    end
    redirect_to request.referer
  end

  private
  def order_params
    binding.pry
    params.require(:order).permit Order::ORDER_ATTRS
  end

  def create_order_detail
    @products.each do |item|
      product_id = item.id.to_i
      @order.order_details.create!(
        product_id: product_id,
        quantity: @carts[product_id.to_s],
        price: item.price
      )
    end
  end

  def create_transaction
    binding.pry
    ActiveRecord::Base.transaction do
      @order.save!
      create_order_detail
      clear_carts
      redirect_to root_path
      flash[:success] = t ".success_checkout"
    end
  rescue StandardError
    flash[:danger] = t ".danger_checkout"
    redirect_to carts_path
  end
end
