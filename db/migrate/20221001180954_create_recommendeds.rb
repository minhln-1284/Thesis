class CreateRecommendeds < ActiveRecord::Migration[6.1]
  def change
    create_table :recommendeds do |t|
      t.string :associations

      t.timestamps
    end
  end
end
