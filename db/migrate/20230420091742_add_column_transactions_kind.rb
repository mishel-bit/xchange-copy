class AddColumnTransactionsKind < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :transaction_kind, :string
  end
end
