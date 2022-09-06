class Admin::CategoriesController < Admin::BaseController
  before_action :find_category, only: %i(edit show update destroy)
  before_action :load_categories, only: %i(new)

  def index
    @pagy, @categories = pagy(Category.newest,
                              items: Settings.category.item)
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = t "flashes.update_success"
      redirect_to admin_category_path(@category)
    else
      flash[:danger] = t "flashes.update_failed"
      render :edit
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t "flashes.create_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "flashes.create_failed"
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "flashes.delete_success"
    else
      flash[:danger] = t "flashes.delete_failed"
    end
    redirect_to admin_categories_path
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t "flashes.alert_not_found"
    redirect_to admin_categories_path
  end

  def category_params
    params.require(:category).permit(:name, :category_id, :parent_path)
  end

  def load_categories
    @categories = Category.all
  end
end
