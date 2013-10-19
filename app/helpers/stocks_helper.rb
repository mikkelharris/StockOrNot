require 'open-uri'
require 'csv'

module StocksHelper
	
	def get_value_for_symbol(symbol)
		url = "http://finance.yahoo.com/d/quotes.csv?s=#{symbol}&f=l1"
		csv = CSV.parse(open(url).read)
		result = Array.new
		csv.each do |row|
			result += row
		end
		result.first
	end
end
