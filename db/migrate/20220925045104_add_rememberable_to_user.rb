class AddRememberableToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :reset_password_sent_at, :string
    add_column :users, :reset_password_token, :datetime
  end
end
