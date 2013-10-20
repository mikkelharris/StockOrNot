require 'semantics3'

module ApplicationHelper
	def today_range
		(Date.today.beginning_of_day..Date.today.end_of_day)
	end
	
	def product_under_price(price)
		# @item_value = ItemValue.where("value <= ? AND item.img_url IS NOT NULL", price).order("value DESC").limit(1)
		@item_value = ItemValue.where("value <= ?", price).order("value DESC").limit(1) #unless !@item_value.nil?
		@item_value.first
	end
	
	def load_database(pages, le)
		load_products(pages, le)
	end
	
	private
  API_KEY = 'SEM3547B8A069D38345D3EA45A5705E41112'
  API_SECRET = 'MWNhODYxZTNiYjcwYTlhZmUwN2Q4MzY3NTJlYmY4NWU'
  
	def load_products(max = 5, le = 0)
  	@sem3 ||= Semantics3::Products.new(API_KEY, API_SECRET)
  	@sem3.clear
    @sem3.products_field("cat_id", 13658)
    @sem3.products_field("sitedetails", "latestoffers", "currency", "USD" )
    @sem3.products_field("sitedetails", "latestoffers", "price", le - 1) if le > 0
    @sem3.products_field("sort", "price", "asc")
		
		constructedJson = @sem3.get_query_json("products")
		Rails.logger.debug ">>>>>>>#{constructedJson}"
		productsHash = @sem3.get_products
		
		page = 0
		while (page < max)
			page = page + 1
			
			productsHash["results"].each do |product|
				next if product["sitedetails"].nil?
				product_name = product["name"]
				product_base_url = product["sitedetails"].first["name"]
				product_full_url = product["sitedetails"].first["url"]
				
				@item = Item.find_by(name: product_name)
				@item = Item.new({name: product_name, base_site: product_base_url, full_site: product_full_url}) if @item.nil?
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
			
			productsHash = @sem3.iterate_products
		end
	end
end
