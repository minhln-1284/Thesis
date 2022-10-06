class AddHashFromToRecommended < ActiveRecord::Migration[6.1]
  def change
    add_column :recommendeds, :hash_from, :string
  end
end
