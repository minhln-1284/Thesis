class AddRecommendToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :recommend, :string
  end
end
