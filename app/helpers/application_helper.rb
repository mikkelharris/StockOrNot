require 'semantics3'

module ApplicationHelper
	def today_range
		(Date.today.beginning_of_day..Date.today.end_of_day)
	end
	
	# sem3.products_field( "cat_id", 4992 )
	# sem3.products_field( "brand", "Toshiba" )
	# sem3.products_field( "weight", "gte", 1000000 )
	# sem3.products_field( "weight", "lt", 1500000 )
	# sem3.products_field( "sitedetails", "name", "newegg.com" )
	# sem3.products_field( "sitedetails", "latestoffers", "currency", "USD" )
	# sem3.products_field( "sitedetails", "latestoffers", "price", "gte", 100 )
	
	
	# Let's view the JSON query we just constructed. This is a good starting point to debug, if you are getting incorrect 
	# results for your query
	# constructedJson = sem3.get_query_json("products")
	
	def product_under_price(price)
		#products_under_price price
		@item_values = ItemValue.where(value: (0..price))
		@item_values = @item_values.uniq { |item_value| item_value.item.id }
		@item_values.sample
	end
	
	private
	API_KEY = 'SEM3547B8A069D38345D3EA45A5705E41112'
	API_SECRET = 'MWNhODYxZTNiYjcwYTlhZmUwN2Q4MzY3NTJlYmY4NWU'
	
	def sem3
		@sem3 ||= Semantics3::Products.new(API_KEY,API_SECRET)
	end
	
	def products_under_price(price)
		sem3
		
		@sem3.products_field("cat_id", 13658)
		@sem3.products_field("sitedetails", "latestoffers", "currency", "USD" )
		@sem3.products_field("sitedetails", "latestoffers", "price", "gte", 0)
		@sem3.products_field("sitedetails", "latestoffers", "price", "lt", price)
		
		# Make the query
		productsHash = sem3.get_products
		
		# View the results of the query
		# Rails.logger.debug productsHash.to_json
		Rails.logger.debug productsHash.class
		
		productsHash["results"].each do |product|
			Rails.logger.debug product
		  
		  product_name = product["name"]
		  product_url = product["sitedetails"].first["url"]
			
			@item = Item.find_by(name: product_name)
			@item = Item.new({name: product_name, img_source: product_url}) if @item.nil?
			if !@item.save
				Rails.logger.debug "Error saving item object: #{@item.errors}"
			else
				product_price = product["price"]
				@item_value = ItemValue.find_by(value: product_price, created_at: today_range)
				@item_value = ItemValue.new({value: product_price, item: @item}) if @item_value.nil?
				
				if !@item_value.save
					Rails.logger.debug "Error saving item_value object #{@item_value.errors}"
				end
			end
		end
	end
end
