class StocksController < ApplicationController
	def show
	end
	
	def new
  	@stock = Stock.new
  end
  
  def create
	  @stock = Stock.find_by(stock_symbol: stock_params[:stock_symbol])
	  if !@stock
		  @stock = Stock.new(stock_params)
		end
  
  	if @stock.save
  		redirect_to root_path, notice: 'Stock was successfully created.'
  	else
  		redirect_to :root
  	end
  end
  
  private
  def stock_params
	  params.require(:stock).permit(:stock_symbol)
	end
end
