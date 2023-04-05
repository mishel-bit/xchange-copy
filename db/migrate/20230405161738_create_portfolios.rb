class CreatePortfolios < ActiveRecord::Migration[7.0]
  def change
    create_table :portfolios do |t|
      t.string :symbol
      t.string :company_name
      t.decimal :amount
      
      t.timestamps
    end
  end
end
