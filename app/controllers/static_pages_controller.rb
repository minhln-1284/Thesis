class StaticPagesController < ApplicationController
  include StaticPagesHelper
    
  def index
    @banners = Banner.all
    @products = Product.all.limit(4)
    if @most_viewed.nil?
      @most_viewed = Recommended.most_viewed
    end
    recommend_for_you
  end

  def mens
    @category = Category.find_by(id: 1)
    product_list = []
    @category.categories.each do |cate|
      cate.products.each do |product|
        product_list << product
      end
    end
    @pagy, @products = pagy product_list
  end

  def womans
    @categories = Category.womans
  end
end
