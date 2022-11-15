class Admin::StaticPagesController < Admin::BaseController
  def index
    @q = Product.ransack(params[:q])
    @products = Product.group(:category_id).count
    @orders = Order.group(:user_id).count
    @order_details = OrderDetail.group(:product_id).count
  end
end
