class StocksController < ApplicationController
	include StocksHelper, ApplicationHelper
	before_filter :set_stock, :only => %w{edit update show}

	def show
	end

	def new
		@stock = Stock.new
	end

	def create
		stock_params[:stock_symbol] = stock_params[:stock_symbol].upcase

		@stock = Stock.find_by(stock_symbol: stock_params[:stock_symbol])
		@stock = Stock.new(stock_params) if @stock.nil?

		value = get_value_for_symbol(@stock.stock_symbol)
		@stock_value = StockValue.find_by(value: value, created_at: today_range)
		@stock_value = StockValue.new({stock: @stock, value: value}) if @stock_value.nil?

		if @stock.save && @stock_value.save
			redirect_to stock_value_url(@stock_value), notice: 'Stock was successfully created.'
		else
			redirect_to :root
		end
	end

	private
	def set_stock
    @stock = Stock.find(params[:id])
  end
	def stock_params
		params.require(:stock).permit(:stock_symbol)
	end
end
