module StaticPagesHelper
  include Pagy::Backend

  def pagy_products category_id
    @pagy, @products = pagy(Product.find_category_id(category_id), items: Settings.product.item)
  end
end
