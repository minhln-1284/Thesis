class Apriori < ApplicationRecord
  def compare_hash_order
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
      h1[o.id] = list_item
    end
    return h1
  end

  def compare_hash_session
    events = Ahoy::Event.all
    h1 = {}
    events.each do |e|
      if e.properties["controller"] == "products" and !e.properties["id"].nil?
        if h1[e.visit_id].nil?
          h1[e.visit_id] = []
        end

        h1[e.visit_id] << e.properties["id"].to_i
      end
    end
    return h1
  end

  def initialize_asso(h1)
    arr = h1.values
    asso = []
    arr.each do |pids|
      asso = (asso + pids).uniq
    end
    return asso
  end

  def compare(combinations, h1, ratio)
    pop_out = []
    min_sup = (Order.all.count * ratio).to_i

    combinations.each do |combo|
      count = 0
      h1.each do |k, v|
        if (combo - v).empty?
          count += 1
        end
      end

      if count < min_sup
        pop_out << combo
      end
    end
    return (combinations - pop_out)
  end

  #ratio of order: 0.22
  def apriori(version)
    k = 1
    if version == "order"
      h1 = compare_hash_order
      result = initialize_asso h1
    else
      h1 = compare_hash_session
      result = initialize_asso h1
    end
    while (true)
      combinations = result.combination(k).to_a

      if combinations.empty?
        break
      end
      combinations = compare(combinations, h1, 0.216)

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
    if result.size > 1
      items = ""
      result.each do |product|
        items = items + product.to_s + "-"
      end
      Recommended.create!(associations: items, hash_from: version)
    end
    return result
  end

  def recommend
    #Muốn nhìn kỹ hơn customer nào được recommend list gì thì bỏ scope this_month đi
    if !Recommended.last.nil? and Recommended.last.hash_from == "order"
      associations = Recommended.last.associations.split("-")
      associations.map! { |e| e.to_i }
      k = 1
      rules = {}
      while k < associations.size
        combinations_list = associations.combination(k)
        combinations_list.each do |combo|
          left = combo
          right = associations - left
          rules[left] = right
        end
        k += 1
      end

      compare_hash = compare_hash_order
      rules.each do |k, v|
        upper = 0
        below = 0
        compare_hash.each do |k1, v1|
          count1 = associations - v1
          count2 = k - v1
          if count1.empty?
            upper += 1
          end
          if count2.empty?
            below += 1
          end
        end
        if below != 0
          confidence = upper / below
          if confidence < 0.1
            rules.delete(k)
          end
        end
      end

      return rules
    end
  end





end
