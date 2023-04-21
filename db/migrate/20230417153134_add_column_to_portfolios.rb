class AddColumnToPortfolios < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolios, :user_id, :integer
  end
end
