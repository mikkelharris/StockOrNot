# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131019124252) do

  create_table "decisions", force: true do |t|
    t.integer "item_value_id"
    t.integer "stock_value_id"
    t.integer "winner"
  end

  add_index "decisions", ["item_value_id"], name: "index_decisions_on_item_value_id", using: :btree
  add_index "decisions", ["stock_value_id"], name: "index_decisions_on_stock_value_id", using: :btree

  create_table "item_values", force: true do |t|
    t.float   "value"
    t.integer "item_id"
  end

  add_index "item_values", ["item_id"], name: "index_item_values_on_item_id", using: :btree

  create_table "items", force: true do |t|
    t.string "img_ref"
    t.string "name"
    t.string "img_source"
  end

  create_table "stock_values", force: true do |t|
    t.float   "value"
    t.integer "stock_id"
  end

  add_index "stock_values", ["stock_id"], name: "index_stock_values_on_stock_id", using: :btree

  create_table "stocks", force: true do |t|
    t.string "stock_symbol"
  end

end