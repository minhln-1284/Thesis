class Recommended < Primary2
  require "apriori"

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
      list.each_with_object(Hash.new(0)) { |m, h| h[m] += 1 }.sort_by { |k, v| v }.map(&:first)
      product_list = []
      list.each do |pid|
        product = Product.find_by(id: pid)
        product_list << product
      end
      if product_list.size < 12
        take_item = 12 - product_list.size
        extra = Product.order(Arel.sql("rand()")).first(take_item)
        product_list += extra
      end
      product_list.uniq!

      return product_list
    end
  end

  def self.test_data(dataset)
    #Bao giờ muốn xóa cả bảng recommend thì vào rails console thực hiện lệnh destroy_all này
    #Recommended.destroy_all
    h1 = []
    Order.all.each do |order|
      h1 << order.products.pluck(:id)
    end
    item_set = Apriori::ItemSet.new(h1)
    support = 0.05
    confidence = 0.6
    rules = item_set.mine(support, confidence)
    rules.keys.each do |key|
      Recommended.create!(associations: key, dataset: dataset)
    end
    p "Finish time: " + Time.now.strftime("%d/%m/%Y %H:%M")
  end

  def self.insert_recommend_user
    users = User.all
    users.each do |user|
      if user.orders.any?
        bought = []
        user.orders.each do |order|
          pids = order.products.pluck(:id)
          bought = (bought + pids).uniq
        end
        recommend_1 = []
        recommend_2 = []
        recommend_3 = []
        Recommended.all.each do |asso|
          associations = asso.associations.split("=>").map! { |id| id.to_i }
          if bought.include? associations.first and !bought.include? associations.second
            case asso.dataset.to_i
            when 1
              recommend_1 << associations.second
            when 2
              recommend_2 << associations.second
            when 3
              recommend_3 << associations.second
            end
          end
        end
        recommend_1.uniq!
        recommend_3.uniq!
        recommend_2.uniq!
        if !recommend_1.empty?
          user.update(recommend_1: recommend_1)
        end
        if !recommend_2.empty?
          user.update(recommend_2: recommend_2)
        end
        if !recommend_3.empty?
          user.update(recommend_3: recommend_3)
        end
      end
    end
  end
end
