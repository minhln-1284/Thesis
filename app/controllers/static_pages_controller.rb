class StaticPagesController < ApplicationController
  def index
    @products = Product.all.limit(4)
  end
end
