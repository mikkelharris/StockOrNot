StockShop::Application.routes.draw do
	root 'pages#root'
	
	resources :stocks
end
