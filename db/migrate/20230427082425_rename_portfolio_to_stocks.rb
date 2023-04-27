class RenamePortfolioToStocks < ActiveRecord::Migration[7.0]
  def change
    rename_table('portfolios','stocks')
  end
end
