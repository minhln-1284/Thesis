class ProductsController < ApplicationController
  include ProductsHelper

  before_action :current_visitor_selections

  def index
    @q = Product.without_deleted.categorized.ransack(params[:q])
    unless !@q.result.empty?
      flash[:danger] = "Can't find what you look for"
      redirect_to root_path
      return
    end
    @pagy, @products = pagy @q.result
  end

  def mens
    @search = Product.without_deleted.categorized.mens.ransack(params[:q])
    @pagy, @products = pagy @search.result
  end

  def womans
    @search = Product.without_deleted.categorized.womans.ransack(params[:q])
    @pagy, @products = pagy @search.result
  end

  def show
    visitor_selection(params[:id])
    @product = Product.without_deleted.categorized.find_by(id: params[:id])
    @ratings = Rating.where(product_id: params[:id])
    if current_user.present?
      @rating = current_user.ratings.build
    end
    if @product.present?
      @ratings_stats = @ratings if @ratings.present?
      @pagy, @ratings = pagy @ratings if @ratings.present?

      @same_category = @product.category.products.where.not(id: params[:id]).sample(10)
    end
    return if @product.present?

    flash[:danger] = t "static_pages.product_not_found"
    redirect_to root_path
  end

  def result
    @name = params[:name]
    @pagy, @products = pagy Product.without_deleted.categorized.by_name params[:name]
  end

  def all_product(category_id)
  end

  private

  def visitor_selection(pid)
    session[:selection] ||= []

    if !session[:selection].include? pid.to_i
      session[:selection].unshift pid.to_i
    end
  end
end
