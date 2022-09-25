class ProductsController < ApplicationController
  def index
  end

  def mens
    @search = Product.mens.oldest.ransack(params[:q])
    @pagy, @products = pagy @search.result
    # @pagy, @products = pagy Product.mens.oldest
  end

  def show
    @product = Product.find_by(id: params[:id])
    @ratings = Rating.where(product_id: params[:id]).newest
    @pagy, @ratings = pagy @ratings if @ratings.present?
    return if @product.present?

    flash[:danger] = t "static_pages.product_not_found"
    redirect_to root_path
  end

  def result
    @name = params[:name]
    @pagy, @products = pagy Product.by_name params[:name]
  end

  def all_product category_id

  end
end
