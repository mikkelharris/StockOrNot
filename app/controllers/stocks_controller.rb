class StocksController < ApplicationController
	include StocksHelper, ApplicationHelper
	before_filter :set_stock, :only => %w{edit update show}

	def show
	end

	def new
		@stock = Stock.new
	end

	def create
		@symbol = stock_params[:stock_symbol].upcase
		@exchange = stock_params[:stock_exchange]


		# @stock = Stock.new(stock_params)
		# @stock.stock_symbol = @stock.stock_symbol.upcase

		@stock = Stock.find_or_create_by(stock_symbol: @symbol, stock_search: @exchange)
		@exchange = nil if @exchange.eql? "USA"
		stock_array = stock_details(@symbol, @exchange)
		@stock_value = StockValue.find_by(value: stock_array[2], created_at: today_range)
		@stock_value = StockValue.new({stock: @stock, value: stock_array[2]}) if @stock_value.nil?
		@stock.name = stock_array[0]
		@stock.stock_exchange = stock_array[1]
		Rails.logger.debug ">>>>>>#{@stock.inspect}"

		Rails.logger.debug ">>>>>>#{stock_array.inspect}"

		if @stock.save && @stock_value.save
			@decision = Decision.new
			@decision.stock_value = @stock_value
			@decision.item_value = product_under_price(@stock_value.value)
			redirect_to decision_url(@decision), notice: 'Stock was successfully created.' if @decision.save
		else
			redirect_to :root
		end
	end

	private
	def set_stock
    @stock = Stock.find(params[:id])
  end
	def stock_params
		params.require(:stock).permit(:stock_symbol, :stock_exchange, :name, :stock_search)
	end
end
