module Admin::UserHelper
  def latest_comment rating
    @rating = rating
    @rating.present? ? @rating.comment : t("admin.category.none")
  end

  def count_delivered orders
    @orders = orders.Delivered.size
    "Delivered: #{@orders}"
  end

  def count_pending orders
    @orders = orders.Pending.size
    "Delivered: #{@orders}"
  end

  def count_shipping orders
    @orders = orders.Shipping.size
    "Shipping: #{@orders}"
  end

  def style_pending pending
    sanitize "<div class='btn btn-info'>#{pending}</div>"
  end

  def style_shipping shipping
    sanitize "<div class='btn btn-primary'>#{shipping}</div>"
  end
end
