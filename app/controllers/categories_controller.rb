class CategoriesController < ApplicationController
  def show
    filter_branch params[:filter]
  end

  private

  def filter_branch(filter)
    case filter
    when "Oldest"
      @pagy, @products = pagy(Product.without_deleted.categorized.by_category(params[:id]).oldest,
                              items: Settings.product.item)
    when "Most expensive"
      @pagy, @products = pagy(Product.without_deleted.categorized.by_category(params[:id]).most_expensive,
                              items: Settings.product.item)
    when "Cheapest"
      @pagy, @products = pagy(Product.without_deleted.categorized.by_category(params[:id]).cheapest,
                              items: Settings.product.item)
    else
      @pagy, @products = pagy(Product.without_deleted.categorized.by_category(params[:id]).newest,
                              items: Settings.product.item)
    end
  end
end
