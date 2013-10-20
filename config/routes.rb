StockShop::Application.routes.draw do
  root 'pages#root'
  
  resources :stocks, :stock_values, :decisions
  
  get 'load_me', to: 'pages#load_me'
end
