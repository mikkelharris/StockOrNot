class StocksController < ApplicationController
	include StocksHelper, ApplicationHelper
	before_filter :set_stock, :only => %w{edit update show}

	def show
	end

	def new
		@stock = Stock.new
	end

	def create
		@stock = Stock.new(stock_params)
		@stock.stock_symbol = @stock.stock_symbol.upcase

		@stock = Stock.find_by(stock_symbol: @stock.stock_symbol, stock_exchange: @stock.stock_exchange)
		@stock = Stock.new(stock_params) if @stock.nil?

		value = stock_details(@stock.stock_symbol, @stock.stock_exchange)
		@stock_value = StockValue.find_by(value: value, created_at: today_range)
		@stock_value = StockValue.new({stock: @stock, value: value}) if @stock_value.nil?

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
		params.require(:stock).permit(:stock_symbol, :stock_exchange)
	end
end
