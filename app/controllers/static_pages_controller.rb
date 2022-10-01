class StaticPagesController < ApplicationController
  def index
    @banners = Banner.all
    @products = Product.all.limit(4)
    if !current_user.nil?
      if !current_user.recommend.nil?
        arr = current_user.recommend.split("-")
        @recommendations = []
        arr.each do |id|
          item = Product.find_by(id: id.to_i)
          @recommendations << item
        end
      end
    end
    
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
