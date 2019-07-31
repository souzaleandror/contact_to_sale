Rails.application.routes.draw do
	post 'receive_emails/read_email', to: 'receive_emails#read_email', :as => :read_email  
  get 'receive_emails/after_read_email', to: 'receive_emails#after_read_email', :as => :after_read_email  
  resources :receive_emails
  root 'receive_emails#index'
  #root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
