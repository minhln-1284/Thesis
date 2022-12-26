module StaticPagesHelper
  include Pagy::Backend

  def pagy_products(category_id)
    @pagy, @products = pagy(Product.categorized.without_deleted.find_category_id(category_id), items: Settings.product.item)
  end

  def recommend_for_you
    if !session[:selection].nil?
      @recomends = []
      product_list = session[:selection]
      product_list.map! { |p| p.to_i }

      session_associations = []
      associations = Recommended.last(2)
      associations.each do |a|
        pids = a.associations.split("-")
        pids.map! { |id| id.to_i }
        session_associations = (session_associations + pids).uniq
      end
    end
  end

  def get_product_array(recommends)
    product_arr = []
    recommends.each do |rec|
      begin
        p = Product.categorized.without_deleted&.find(rec)
      rescue
        next
      end
      if p.present?
        product_arr << p
      end
    end
    return product_arr
  end

  def best_sellings
    if OrderDetail.any?
      products = OrderDetail.group(:product_id).order("count_all DESC").count.keys
      return Product.without_deleted.categorized.where(id: products).take(4)
    end
  end
end
