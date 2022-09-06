class RemoveTotalFromOrderDetail < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_details, :total, :decimal
  end
end
