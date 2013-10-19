class PagesController < ApplicationController
	include ApplicationHelper
	def root
    @stock = Stock.new
	end
end
