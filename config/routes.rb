Rails.application.routes.draw do
	root 'index#index'
  get 'index/fetch_new_data'
  get 'index/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
