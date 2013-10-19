class CreateItem < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :img_ref
      t.string :name
      t.string :img_source
    end
  end
end
