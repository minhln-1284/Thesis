module ProductsHelper
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

  def checkout_these_product
    session[:selection] ||= []
    recommend_pids = []
    if recommend_pids.size < 8
      session[:selection].each do |pid|
        products = Product.find_by(id: pid).category.products.sample(2).pluck(:id)
        recommend_pids = (recommend_pids + products).uniq
        if recommend_pids.size >= 8
          break
        end
      end
    end
    if !current_visit.user_id.nil?
      user = User.find_by(id: current_visit.user_id)
      if !user.recommend.nil?
        user_bought = eval(user.recommend)
        check = session[:selection] - user_bought
        if check != session[:selection]
          recommend_pids = user_bought - session[:selection]
        end
      end
    end
    #Sau khi test với tập dữ liệu lớn thì cân nhắc xem có cần cho đoạn
    #so với rule trong DB có cần phải làm background job để cải thiện tốc độ không nhé
    if recommend_pids.size < 8
      rules = Recommended.all
      rules.each do |rule|
        associations = rule.associations.split("=>").map! { |id| id.to_i }
        left = []
        left << associations.first
        check = recommend_pids - left
        if check != recommend_pids
          second = []
          second << associations.second
          recommend_pids = (recommend_pids + second).uniq
        end
      end
    end
    #-----------------------------------------------------------------------------------
    if recommend_pids.size < 8
      extras = Product.all.sample(8).pluck(:id)
      recommend_pids = (recommend_pids + extras).uniq
    end

    if recommend_pids.size > 8
      recommend_pids = recommend_pids.sample(8)
    end
    return recommend_pids
  end
end
