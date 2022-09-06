class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.string :comment
      t.integer :star
      t.references :user, null: false, foreign_key: true
      t.bigint :product_id, null: false

      t.timestamps
    end
  end
end
