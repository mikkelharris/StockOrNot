class Stock < ActiveRecord::Base
	has_many :stock_values
end
