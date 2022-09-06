class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  scope :order_by_ids, ->(ids){where order_id: ids}

  delegate :name, to: :product

  scope :this_month, (lambda do
    where(created_at:
      DateTime.now.beginning_of_month..DateTime.now.end_of_month)
  end)
end
