require 'open-uri'
require 'csv'

module StocksHelper
	
	def stock_details(symbol, exchange)
		url = "http://finance.yahoo.com/d/quotes.csv?s=#{symbol}.#{exchange}&f=l1"
		csv = CSV.parse(open(url).read)
		result = Array.new
		csv.each do |row|
			result += row
		end
		result.first
	end
end
