class Decision < ActiveRecord::Base
  belongs_to :stock_value
  belongs_to :item_value
end
