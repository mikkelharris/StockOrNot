class AddTimestampsToStocksAndStockValues < ActiveRecord::Migration
  def change
    change_table :stocks do |t|
      t.timestamps
    end
    
    change_table :items do |t|
      t.timestamps
    end
    
    change_table :stock_values do |t|
      t.timestamps
    end
    
    change_table :item_values do |t|
      t.timestamps
    end
    
    change_table :decisions do |t|
      t.timestamps
    end
  end
end
