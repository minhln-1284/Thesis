module ApplicationHelper
  include Pagy::Frontend
  include Admin::OrderHelper

  def load_categories
    @categories = Category.newest
  end
end
