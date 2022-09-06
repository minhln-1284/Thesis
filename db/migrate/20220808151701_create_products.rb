class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :description
      t.integer :quantity_in_stock
      t.references :category, foreign_key: true, null: true
      t.timestamps
    end
    add_foreign_key :ratings, :products
  end
end
