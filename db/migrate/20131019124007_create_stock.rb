class CreateStock < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :stock_symbol
    end
  end
end
