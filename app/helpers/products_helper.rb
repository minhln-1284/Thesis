module ProductsHelper
  def average_star(ratings)
    sum = 0
    count = 0
    ratings.each do |rating|
      sum += rating.star.to_i
      count += 1
    end
    return sum / count
  end

  def star_statistic(ratings)
    arr = [0, 0, 0, 0, 0, 0]
    sum = 0
    ratings.each do |rating|
      case rating.star
      when 1
        arr[0] += 1
      when 2
        arr[1] += 1
      when 3
        arr[2] += 1
      when 4
        arr[3] += 1
      when 5
        arr[4] += 1
      end
      sum += rating.star
    end
    arr[5] = sum / ratings.size
    return arr
  end

  def generate_related(product)
    associated_products = Recommended.last.associations.split("-")
    related = product.category.products.all.limit(10)
    if (associated_products.include? product.id.to_s)
      associated_products.delete(product.id.to_s)
      related = related.pluck(:id)
      associated_products.each do |product|
        related << product.to_i
      end
      @products = Product.where(id: related.uniq)
      return @products
    end
    return related
  end

  def current_visitor_selections
    session[:selection] ||= []
    @selections = session[:selection]
  end

  def allow_comment(product)
    allow = false
    product.orders.each do |order|
      if order.user_id == current_user.id
        allow = true
        break
      end
    end
    return allow
  end

  def checkout_these_product
    session[:selection] ||= []
    recommend_pids = []
    if !current_visit.user_id.nil?
      user = User.find_by(id: current_visit.user_id)
      if !user.recommend.nil?
        recommend_pids = eval(user.recommend)
      end
    end
    if session[:selection].present?
      rules = Recommended.all
      rules.each do |rule|
        associations = rule.associations.split("=>").map! { |id| id.to_i }
        left = []
        left << associations.first
        check = session[:selection] - left
        if check != session[:selection]
          second = []
          second << associations.second
          recommend_pids = (recommend_pids + second).uniq
        end
      end
    end
    if session[:selection].present?
      session[:selection].each do |pid|
        products = Product.find_by(id: pid).category.products.sample(2).pluck(:id)
        recommend_pids = (recommend_pids + products).uniq
      end
    end
    #-----------------------------------------------------------------------------------
    if recommend_pids.size > 15
      recommend_pids = recommend_pids.take(15)
    end
    if recommend_pids.empty?
      recommend_pids = Product.all.sample(15).pluck(:id)
    end
    return recommend_pids
  end
end
