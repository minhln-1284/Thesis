class StaticPagesController < ApplicationController
  def index
    @products = Product.all.limit(4)
  end

  def mens
    @categories = Category.mens
  end

  def womans
    @categories = Category.womans
  end
end
