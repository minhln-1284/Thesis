module StaticPagesHelper
  include Pagy::Backend

  def pagy_products(category_id)
    @pagy, @products = pagy(Product.find_category_id(category_id), items: Settings.product.item)
  end

  def recommend_for_you
    if !session[:selection].nil?
      @recomends = []
      product_list = session[:selection]
      product_list.map!{|p| p.to_i}

      session_associations = []
      associations = Recommended.last(2)
      associations.each do |a|
        pids = a.associations.split("-")
        pids.map!{|id| id.to_i}
        session_associations = (session_associations + pids).uniq
      end
      binding.pry
    end
  end
end
