module Admin::OrderHelper
  def style_status status
    case status
    when "Pending"
      class_type = "info"
    when "Shipping"
      class_type = "primary"
    when "Delivered"
      class_type = "success"
    when "Canceled"
      class_type = "warning"
    when "Rejected"
      class_type = "danger"
    end
    sanitize "<div class='btn btn-#{class_type}'>#{status}</div>"
  end

  def options_for_status current_status
    case current_status
    when "Pending"
      %w(Shipping Rejected)
    when "Shipping"
      %w(Delivered Canceled)
    else
      []
    end
  end

  def can_change? current_status
    if (current_status == "Rejected") ||
       (current_status == "Canceled") || (current_status == "Delivered")
      false
    else
      true
    end
  end
end
