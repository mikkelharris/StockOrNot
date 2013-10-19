StockShop::Application.routes.draw do
	root 'pages#root'
	
	resources :stocks, :stock_values
end
