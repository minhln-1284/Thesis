class StaticPagesController < ApplicationController
  def index
    @products = Product.all.limit(4)
    if !current_user.nil?
      if !current_user.recommend.empty?
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
    @categories = Category.mens
  end

  def womans
    @categories = Category.womans
  end
end
