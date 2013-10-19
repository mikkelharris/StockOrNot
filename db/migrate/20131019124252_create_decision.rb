class CreateDecision < ActiveRecord::Migration
  def change
    create_table :decisions do |t|
      t.references :item_value, index: true
      t.references :stock_value, index: true
      t.integer :winner
    end
  end
end
