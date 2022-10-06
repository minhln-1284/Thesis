class Recommended < ApplicationRecord
  def self.most_viewed
    if Ahoy::Event.any?
      list = []
      limit_count = 0
      Ahoy::Event.all.pluck(:properties).each do |p|
        if p["controller"] == "products" and p["action"] == "show"
          list << p["id"].to_i
          limit_count += 1
        end
        if limit_count >= 12
          break
        end
      end
      list.each_with_object(Hash.new(0)){ |m,h| h[m] += 1 }.sort_by{ |k,v| v }.map(&:first)
      product_list = []
      list.each do |pid|
        product = Product.find_by(id: pid)
        product_list << product
      end
      if product_list.size < 12
        take_item = 12 - product_list.size
        extra = Product.order(Arel.sql('rand()')).first(take_item)
        product_list += extra
      end
      return product_list
    end
  end

  def self.test_data
    order_detail = OrderDetail.all
    order = Order.all
    h1 = []
    order.each do |o|
      list_item = []
      order_detail.each do |od|
        if od.order_id == o.id
          list_item << (od.product.id)
        end
      end
      h1 << list_item
    end
    return h1
  end
end
