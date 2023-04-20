class RenameColumnInTransaction < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :action, :transaction_kind
    change_column :transactions, :amount, :decimal
  end
end
