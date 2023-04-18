class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :symbol
      t.decimal :price
      t.integer :amount
      t.string :action
      
      t.timestamps
    end
  end
end
