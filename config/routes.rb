StockShop::Application.routes.draw do
	root 'pages#root'
	
	resource :stocks, only: [:show, :new, :create]
end
