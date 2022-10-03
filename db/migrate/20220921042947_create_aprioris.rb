class CreateAprioris < ActiveRecord::Migration[6.1]
  def change
    create_table :aprioris do |t|

      t.timestamps
    end
  end
end
