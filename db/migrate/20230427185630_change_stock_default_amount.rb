class ChangeStockDefaultAmount < ActiveRecord::Migration[7.0]
  def change
    change_column :stocks, :amount, :decimal, :default => 0
  end
end
