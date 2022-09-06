module Admin::CategoryHelper
  def find_parent category
    parent = category.category
    parent.nil? ? t("admin.category.none") : parent.name
  end

  def options_for_category category
    options = Category.pluck :name, :id
    options.delete [category.name.to_s, category.id]
    options.unshift ["None", nil]
  end
end
