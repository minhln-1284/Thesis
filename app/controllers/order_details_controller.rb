class OrderDetailsController < ApplicationController
  def show
    @order_total = Order.find_by id: params[:id]
    if @order_total.present?
      @ods = OrderDetail.includes(:product).order_by_ids(params[:id])
    else
      flash[:danger] = t "static_pages.order_not_found"
    end
  end
end
