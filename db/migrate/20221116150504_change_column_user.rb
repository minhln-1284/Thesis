class ChangeColumnUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :reset_password_sent_at, :datetime
    change_column :users, :reset_password_token, :string
  end
end
