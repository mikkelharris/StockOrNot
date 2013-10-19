class StockValuesController < ApplicationController
  before_filter :set_stock_value, :only => %w{edit update show}

  
  def new
    @stock_value = StockValue.new
  end

  def show
  end


  private

  def set_stock_value
    @stock_value = StockValue.find(params[:id])
  end
  
  def stock_value_params
    params.require(:stock_value).permit(:value)
  end
end
