class RenamePortfolioIdToStocksId < ActiveRecord::Migration[7.0]
  def change
    rename_column :transactions, :portfolio_id, :stock_id
  end
end
