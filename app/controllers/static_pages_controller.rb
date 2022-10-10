class StaticPagesController < ApplicationController
  include StaticPagesHelper
  include ProductsHelper
  @@count = 0
  @@recommendations
  @@most_viewed

  def index
    @banners = Banner.all

    if @@count == 0
      @@most_viewed = Recommended.most_viewed
      if @@most_viewed.nil?
        @@most_viewed = Product.sample(4)
      end
      @products = @@most_viewed.take(4)
    else
      @products = @@most_viewed.take(4)
    end

    if @@count == 0
      recommends = checkout_these_product
      @recommendations = Product.where(id: recommends)
      session[:recommend] = recommends
      @@count += 1
    elsif @@count < 3
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
