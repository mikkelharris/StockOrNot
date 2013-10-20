class PagesController < ApplicationController
	include ApplicationHelper, ItemsHelper
  def root
    @stock = Stock.new
  end
  
  def load_me
    load_the_database 5, 10
  end
end
