class PagesController < ApplicationController
	include ApplicationHelper, ItemsHelper
  def root
    @stock = Stock.new
  end
end
