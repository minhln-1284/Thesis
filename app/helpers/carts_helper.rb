module CartsHelper
  def current_cart
    user_id = session[:user_id]
    session["cart_#{user_id}"] ||= {}
    @carts = session["cart_#{user_id}"] ||= {}
  end

  def total_cart
    @products = Product.by_ids current_cart.keys
    @products.reduce(0) do |total, product|
      total + product.price * @carts[product.id.to_s].to_i
    end
  end

  def total_price_product id
    product = Product.find_by id: id
    product.price * @carts[id.to_s].to_i
  end

  def load_product_in_cart
    @products = Product.by_ids current_cart.keys
  end

  def clear_carts
    user_id = session[:user_id]
    session["cart_#{user_id}"] = {}
  end

  def check_product_quantity
    @products.each do |item|
      product_id = item.id.to_i
      quantity = @carts[product_id.to_s]
      if item.quantity_in_stock < quantity
        flash[:danger] = t(".danger_quantity", prod_id: product_id)
        redirect_to carts_path
      end
    end
  end
end
