module Admin::ProductHelper
  def category_name category_id
    category = @categories.find_by id: category_id
    category.nil? ? t("admin.category.none") : category.name
  end

  def in_category categories
    output = []
    categories.each do |cate|
      input = [cate.name, cate.id.to_s]
      output.append input
    end
    output.append ["None", ""]
  end
end
