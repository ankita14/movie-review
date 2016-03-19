Rails.application.routes.draw do
  
  resources :banners
  post '/rate' => 'rater#create', :as => 'rate'
  mount Ckeditor::Engine => '/ckeditor'
  root 'home#index'
  # get '/admins/sign_in' => "/admin ", as: :admin_root
  get '/' => "home#latest", as: :user_root
  
  # match '/admins/sign_in' => "admins/sessions#destroy ", as: :admin_root, via: :delete
  get 'home/index'
  get 'home/about'
  # get 'home/movie_detail'
  # get 'home/movie_genres'
  # get 'home/movie_types'
  match '/reviews/new/:id' => 'reviews#new', :as => :movie_with_review, via: :get
  match '/movie/:id' => 'home#movie_detail', :as => :movie_with_title, via: :get
  match '/movies/types/:id' => 'home#movie_types', :as => :type_with_title, via: :get
  match '/movies/genres/:id' => 'home#movie_genres', :as => :genre_with_title, via: :get  
  match 'movies/top_rated_movies' => 'home#top_rated', via: :get
  match 'movies/upcoming_movies' => 'home#upcoming', via: :get
  match 'movies/latest_movies' => 'home#latest', via: :get
  match '/contact' => 'contacts#new', :as => :contact, via: :get
  resources :contacts
  resources :reviews
  resources :movies
  resources :movies do
    collection do
      get 'bollywood_hungama'
      post 'bollywood_hungama'
      patch 'bollywood_hungama'
    end
    collection do
      get 'hungama_url'
      post 'hungama_url'
      patch 'hungama_url'
    end
    collection do
      get 'mov_with_critic'
      post 'mov_with_critic'
      patch 'mov_with_critic'
    end
  end
  devise_for :admins, controllers: { sessions: "admins/sessions" }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # devise_for :users 
  devise_for :users, controllers: { sessions: "users/sessions" }
  # match '/admin' => '' , :as => :admin_logout_path, via: :get
  # match '/pages/:id' => 'welcome#page', :as => :page_with_title, via: :get  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
