module Admin::ApplicationHelper
  def pie_chart_order orders
    h1 = {}
    orders.each do |key, value|
      user = User.find_by(id: key)
      newkey = user.nil? ? "None" : user.name
      h1[newkey] = value
    end
    h1
  end

  def bar_chart_product products
    h1 = {}
    products.each do |key, value|
      cate = Category.find_by(id: key)
      newkey = cate.nil? ? "None" : cate.name
      h1[newkey] = value
    end
    h1
  end

  def product_purchase_count order_details
    h1 = {}
    order_details.each do |key, value|
      product = Product.find_by(id: key)
      newkey = product.nil? ? "None" : product.name
      h1[newkey] = value
    end
    h1
  end
end
