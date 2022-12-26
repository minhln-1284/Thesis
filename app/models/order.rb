class Order < ApplicationRecord
  acts_as_paranoid without_default_scope: true
  enum status: {Pending: 0, Shipping: 1, Delivered: 2, Canceled: 3,
                Rejected: 4}, _default: 0

  ORDER_ATTRS = %w(quantity price product_id amount phone).freeze

  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details

  belongs_to :user, optional: true

  delegate :name, to: :user

  scope :oldest, ->{order created_at: :asc}
  scope :by_user, ->(uid){where user_id: uid}

  scope :most_order, (lambda do
    Order.Delivered.group(:user_id)
                    .order("count_all DESC").limit(1).count.first.first
  end)

  scope :order_by_price, ->(criteria){order(price: criteria)}
  scope :this_month, (lambda do
    where(created_at:
      DateTime.now.beginning_of_month..DateTime.now.end_of_month)
  end)

  private

  def update_branch
    case status
    when "Shipping", "Delivered"
      order_details = self.order_details
      order_details.each do |order_detail|
        product = order_detail.product
        product.quantity_in_stock -= order_detail.quantity
        product.update!(quantity_in_stock: product.quantity_in_stock)
      end
    when "Rejected", "Canceled"
      order_details = self.order_details
      order_details.each do |order_detail|
        product = order_detail.product
        product.quantity_in_stock += order_detail.quantity
        product.update!(quantity_in_stock: product.quantity_in_stock)
      end
    end
  end
end
