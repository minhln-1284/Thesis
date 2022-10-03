class Admin::BannersController < Admin::BaseController
  before_action :find_banner, only: %i(edit show update destroy)

  def index
    @pagy, @banners = pagy Banner.all
  end

  def new
    @banner = Banner.new
  end

  def show; end

  def create
    @banner = Banner.new(banner_params)
    if @banner.save
      flash[:success] = t "flashes.create_success"
      redirect_to admin_banner_path(@banner)
    else
      flash[:danger] = t "flashes.create_failed"
      render :new
    end
  end

  def update
    if @banner.update(banner_params)
      flash[:success] = t "flashes.update_success"
      redirect_to admin_banner_path(@banner)
    else
      flash[:danger] = t "flashes.update_failed"
      render :edit
    end
  end

  def destroy
    if @banner.destroy
      flash[:success] = t "flashes.delete_success"
    else
      flash[:danger] = t "flashes.delete_failed"
    end
    redirect_to admin_banners_path
  end

  private
  def find_banner
    @banner = Banner.find_by id: params[:id]
    return if @banner

    flash[:danger] = t "flashes.alert_not_found"
    redirect_to admin_banners_path
  end

  def banner_params
    params.require(:banner).permit(:content, :image)
  end
end
