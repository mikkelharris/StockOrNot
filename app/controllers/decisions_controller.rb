class DecisionsController < ApplicationController
  before_filter :set_decision, :only => %w{edit update show}

  def show
  end

  def new
    @decision = Decisions.new
  end

  def create
    if @decision.save
      redirect to @decision
    else
      redirect_to :root
    end
  end

  private
  def set_decision
    @decision = Decision.find(params[:id])
  end
  def stock_params
    params.require(:decision).permit(:stock_value, :item_value, :winner)
  end
end