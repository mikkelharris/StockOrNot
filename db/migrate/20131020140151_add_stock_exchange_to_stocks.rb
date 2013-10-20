class AddStockExchangeToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :stock_exchange, :string
  end
end
