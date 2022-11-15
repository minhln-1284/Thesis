class AddRecommendToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :recommend_1, :string
    add_column :users, :recommend_2, :string
    add_column :users, :recommend_3, :string
  end
end
