class Recommended < ApplicationRecord
  require 'apriori'

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
      product_list.uniq!

      return product_list
    end
  end

  def self.test_data
    Recommended.destroy_all
    h1 = []
    Order.all.each do |order|
      h1 << order.products.pluck(:id)
    end
    item_set = Apriori::ItemSet.new(h1)
    support = 0.1
    confidence = 0.4
    rules = item_set.mine(support, confidence)
    rules.keys.each do |key|
      Recommended.create!(associations: key)
    end
    # users = User.all
    # users.each do |user|
    #   if user.orders.any?
    #     bought = []
    #     user.orders.each do |order|
    #       pids = order.products.pluck(:id)
    #       bought = (bought + pids).uniq
    #     end
    #     recommend = []
    #     rules.keys.each do |key|
    #       associations = key.split("=>").map!{|id| id.to_i}
    #       if bought.include? associations.first and !bought.include? associations.second
    #         recommend << associations.second
    #       end
    #     end
    #     recommend.uniq!
    #     if !recommend.empty?
    #       user.update(recommend: recommend)
    #     end
    #   end
    # end
  end
end
