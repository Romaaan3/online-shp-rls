	Rails.application.routes.draw do

	post '/tinymce_assets' => 'tinymce_assets#create'

	devise_for :users, :path_names => {:sign_in => "login", :sign_out => "logout"}, :path => ""

	constraints :subdomain => "cp.swap" do
	  scope :module => "cp", :as => "cp" do
	    resources :parts do
        collection { post :import }
        collection { get :blank }
      end
	    resources :brands do
        collection { post :import }
        collection { get :blank}
      end
	    resources :categories do
        collection { post :import }
        collection { get :blank}
      end
      resources :stores
      resources :users
      delete "delete_unactivated", to: "users#delete_unactivated_users"
	    resources :orders do
  	 	 	member do
		    	get 'complete'
          get 'pay_order'
          get 'cancel_pay'
		  	end
	  	end
	    resources :movements do
  	 	 	member do
		    	get 'complete'
		  	end
	  	end
	    resources :movement_lineitems
	    resources :order_lineitems
	    resources :emails, only: [:index, :destroy]
	    resources :pictures, only: [:destroy]
	    resources :news
	    resources :blocks
	    resources :leads, only: [:index, :destroy]
			root 'parts#index'
	  end
	end

	constraints :subdomain => "swap" do
	  scope :module => "fe", :as => "fe" do
			root 'static_pages#home'
			resources :emails, only: [:create]
			get "/kontakty", to: "static_pages#kontakty", as: :kontakty
			get "/dostavka-i-oplata", to: "static_pages#dostavka_i_oplata", as: :dip
			# get "/novosti", to: "news#index"
			# get "/novosti/:id", to: "news#show"
			resources :news, only: [:index, :show], path: "novosti"
			get 'katalog(/:brand(/:category))', to: 'catalog#index', as: :catalog_index
			get 'katalog/:brand/:category/:part', to: 'catalog#show', as: :catalog_part
	    resources :leads, only: [:create], :constraints => {:format => /js/}
      resources :carts, only: [:destroy]
      resources :orders, only: [:create]
      match "/cart/checkout" => 'carts#checkout', :via => [:get, :post], as: :cart_checkout
      match "/cart/payment" => 'carts#payment', :via => [:get, :post], as: :cart_payment
      match "/cart/payment_success" => 'carts#payment_success', :via => [:get, :post], as: :cart_payment_success
      match "/cart/payment_error" => 'carts#payment_error', :via => [:get, :post], as: :cart_payment_error
      resources :user do
      end
      get "/profile", to: "user#profile", as: :current_profile

			resources :cart_line_items do
        member do
          put 'decrement'
          put 'increment'
        end
      end
      get "/cart", to: "carts#show", as: :current_cart
		end
	end

  # namespace :cp do
  #   resources :parts
  # end
  # namespace :cp do
  #   resources :categories
  # end
  # namespace :cp do
  #   resources :brands
  # end

	# root "application#index"
	# constraints(:subdomain => /cp/) do
	#   namespace :cp do
	# 		root "cp/application#index"
	#     resources :users
	#     # resources :posts
	#   end
	# end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
