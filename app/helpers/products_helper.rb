module ProductsHelper
  def generate_related product
    associated_products = Recommended.last.associations.split("-")
    related = product.category.products.all.limit(10)
    if(associated_products.include? product.id.to_s)
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
end
