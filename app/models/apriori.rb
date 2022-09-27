class Apriori < ApplicationRecord
  def compare_hash
    order_detail = OrderDetail.all
    order = Order.all
    h1 = {}
    order.each do |o|
    list_item = []
      order_detail.each do |od|
        if od.order_id == o.id
          list_item << (od.product.id)
        end
      end
      newkey = o.id
      h1[newkey] = list_item
    end
    return h1
  end

  def initialize_asso(h1)
    arr = h1.values
    asso = []
    arr.each do |sub|
      sub.each do |item|
        if !asso.include?(item)
          asso << item
        end
      end
    end
    return asso
  end

  def generate_combination(k, arr)
    arr.combination(k).to_a
  end

  def compare(combinations, h1)
    pop_out = []
    combinations.each do |combo|
      count = 0
      h1.each do |h|
        if (combo - h.second).empty?
          count += 1
        end
      end
      min_sup = Order.all.count * 0.22
      if count < min_sup.to_i
        pop_out << combo
      end
    end
    return (combinations - pop_out)
  end

  def apriori
    k = 1
    h1 = compare_hash
    result = initialize_asso h1
    while (true)
      combinations = result.combination(k).to_a

      if combinations.empty?
        break
      end
      combinations = compare(combinations, h1)

      if (combinations.empty?)
        if (k == 1)
          result = []
        end
        break
      else
        temp = []
        combinations.each do |combo|
          combo.each do |item|
            if !temp.include?(item)
              temp << item
            end
          end
        end
        result = temp
        k += 1
      end
    end
    return result
  end

  def self.recommend(apriori)
    #Muốn nhìn kỹ hơn customer nào được recommend list gì thì bỏ scope this_month đi
    users = User.all
    h1 = {}
    users.each do |u|
      items = []
      u.orders.this_month.each do |order|
        items = items + order.products.ids
        items = items.uniq
      end
      h1[u.id] = items
    end

    h1.each do |customer|
      products = customer.second
      sample = products - apriori
      if (products != sample && !sample.empty?)
        bought = products - sample
        recommend = apriori - bought
        if (!recommend.empty?)
          items = ""
          recommend.each do |product|
            items = items + product.to_s + "-"
          end
          user = User.find_by(id: customer.first)
          user.update!(recommend: items)
        end
      end
    end
  end
end

=begin
CÁCH XỬ LÝ LẤY PRODUCT_IDs TRONG CỘT RECOMMEND TỪ DB RA NHÉ
  arr = "2-4-6-7-".split("-")
  product_id = []
  arr.each do |id|
    product_id << id.to_i
  end
=end
