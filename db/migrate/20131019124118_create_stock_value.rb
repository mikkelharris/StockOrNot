class CreateStockValue < ActiveRecord::Migration
  def change
    create_table :stock_values do |t|
      t.float :value
      t.references :stock, index: true
    end
  end
end
