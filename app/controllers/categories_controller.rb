class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(id: params[:id])
    @pagy, @products = pagy @category.products if @category.present?
  end

  def filter
    if params[:filter] == t("static_pages.newest")
      @pagy, @products = pagy Product
                         .find_category_id(params[:id]).newest
    else
      filter_increase(params[:filter], params[:id])
    end
  end

  def filter_increase filter, id
    if filter == t("static_pages.price_increase")
      @pagy, @products = pagy Product
                         .find_category_id(id).order_by_price(:asc)
    else
      @pagy, @products = pagy Product
                         .find_category_id(id).order_by_price(:desc)
    end
  end
end
