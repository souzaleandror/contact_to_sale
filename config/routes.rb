Rails.application.routes.draw do
  resources :receive_emails
  root 'receive_emails#index'
  #root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
