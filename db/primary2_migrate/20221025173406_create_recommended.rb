class CreateRecommended < ActiveRecord::Migration[6.1]
  def change
    create_table :recommendeds do |t|
      t.string :associations
      t.string :dataset

      t.timestamps
    end
  end
end
