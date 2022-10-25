class ProductsController < ApplicationController
  include ProductsHelper

  before_action :current_visitor_selections

  def index
    @q = Product.ransack(params[:q])
    unless !@q.result.empty?
      flash[:danger] = "Can't find what you look for"
      redirect_to root_path
      return
    end
    @pagy, @products = pagy @q.result
  end

  def mens
    @search = Product.mens.ransack(params[:q])
    @pagy, @products = pagy @search.result
  end

  def womans
    @search = Product.womans.ransack(params[:q])
    @pagy, @products = pagy @search.result
  end

  def show
    visitor_selection(params[:id])
    @product = Product.find_by(id: params[:id])
    @ratings = Rating.where(product_id: params[:id])
    if current_user.present?
      @rating = current_user.ratings.build
    end
    @ratings_stats = @ratings if @ratings.present?
    @pagy, @ratings = pagy @ratings if @ratings.present?

    @same_category = @product.category.products.where.not(id: params[:id]).sample(10)

    return if @product.present?

    flash[:danger] = t "static_pages.product_not_found"
    redirect_to root_path
  end

  def result
    @name = params[:name]
    @pagy, @products = pagy Product.by_name params[:name]
  end

  def all_product(category_id)
  end

  private

  def visitor_selection(pid)
    session[:selection] ||= []

    if !session[:selection].include? pid.to_i
      session[:selection] << pid.to_i
    end
  end
end
