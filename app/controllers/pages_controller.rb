class PagesController < ApplicationController
	def root
    @stock = Stock.new
	end
end
