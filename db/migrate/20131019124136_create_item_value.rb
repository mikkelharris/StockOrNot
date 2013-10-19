class CreateItemValue < ActiveRecord::Migration
  def change
    create_table :item_values do |t|
      t.float :value
      t.references :item, index: true
    end
  end
end
