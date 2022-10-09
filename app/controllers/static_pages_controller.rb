class StaticPagesController < ApplicationController
  include StaticPagesHelper
  include ProductsHelper
  @@count = 0
  @@recommendations

  def index
    @banners = Banner.all
    @products = Product.all.limit(4)
    if @most_viewed.nil?
      @most_viewed = Recommended.most_viewed
    end
    if @@count == 0
      recommends = checkout_these_product
      @recommendations = Product.where(id: recommends)
      session[:recommend] = recommends
      @@count += 1
    elsif @@count < 6
      @recommendations = Product.where(id: session[:recommend])
      @@count += 1
    else
      recommends = checkout_these_product
      @recommendations = Product.where(id: recommends)
      session[:recommend] = recommends
      @@count = 1
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
