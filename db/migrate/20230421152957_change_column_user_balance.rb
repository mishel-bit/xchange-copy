class ChangeColumnUserBalance < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :balance, :decimal
  end
end
