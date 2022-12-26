class Admin::ProductsController < Admin::BaseController
  before_action :find_product, only: %i(edit show update destroy)
  before_action :get_categories, only: %i(new edit show update index)

  def index
    filter_branch params
  end

  def show
    @product.product_images.build
  end

  def new
    @product = Product.new
    @product.product_images.build
  end

  def edit; end

  def update
    if @product.update(product_params)
      flash[:success] = t "flashes.update_success"
      redirect_to admin_product_path(@product)
    else
      flash[:danger] = t "flashes.update_failed"
      render :edit
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = t "flashes.create_success"
      redirect_to admin_product_path(@product)
    else
      flash[:danger] = t "flashes.create_failed"
      render :new
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t "flashes.delete_success"
    else
      flash[:danger] = t "flashes.delete_failed"
    end
    redirect_to admin_products_path
  end

  private
  def find_product
    @product = Product.without_deleted.categorized.find_by id: params[:id]
    return if @product

    flash[:danger] = t "flashes.alert_not_found"
    redirect_to admin_products_path
  end

  def product_params
    params.require(:product).permit(:name, :price, :description,
                                    :quantity_in_stock, :category_id,
                                    product_images_attributes:
                                    [:id, :image, :_destroy])
  end

  def get_categories
    @categories = Category.all
  end

  def filter_branch params
    if params[:filter] == t("admin.product.filter.uncate")
      @pagy, @products = pagy(Product.without_deleted.uncategorized,
                              items: Settings.product.item)
    elsif params[:name].present?
      @pagy, @products = pagy(Product.without_deleted.where("name like ?", "%#{params[:name]}%"),
        items: Settings.product.item)
    else
      @pagy, @products = pagy(Product.without_deleted.newest,
                              items: Settings.product.item)
    end
  end
end
