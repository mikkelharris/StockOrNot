class AddStockSearchToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :stock_search, :string
  end
end
