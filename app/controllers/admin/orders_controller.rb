class Admin::OrdersController < Admin::BaseController
  before_action :find_order, only: %i(edit update)

  def index
    @orders = Order.this_month.without_deleted.oldest
    @pagy, @orders2  = pagy(Order.this_month.oldest,
                            items: Settings.order.item)
  end

  def edit
    @order_details = @order.order_details
  end

  def update
    if @order.update(order_params)
      update_branch @order.status
      redirect_to admin_orders_path
    else
      flash[:danger] = t "flashes.update_failed"
      render :edit
    end
  end

  private
  def find_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = t "flashes.alert_not_found"
    redirect_to admin_orders_path
  end

  def order_params
    params.require(:order).permit(:user_id, :amount, :status)
  end

  def update_branch status
    case status
    when "Shipping", "Delivered"
      order_details = @order.order_details
      order_details.each do |order_detail|
        product = order_detail.product
        product.quantity_in_stock -= order_detail.quantity
        product.update!(quantity_in_stock: product.quantity_in_stock)
      end
    when "Rejected", "Canceled"
      order_details = @order.order_details
      order_details.each do |order_detail|
        product = order_detail.product
        product.quantity_in_stock += order_detail.quantity
        product.update!(quantity_in_stock: product.quantity_in_stock)
      end
    end
  end
end
