class AddAccountStatusToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :account_status, :string, :default => "pending"
  end
end
