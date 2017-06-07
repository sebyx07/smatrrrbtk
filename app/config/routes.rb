Rails.application.routes.draw do
  root 'currencies#index'
  post 'currencies', to: 'currencies#get_currency'
end
