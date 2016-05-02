Rails.application.routes.draw do
  
  resources :featured_trailors
  resources :banners
  post '/rate' => 'rater#create', :as => 'rate'
  mount Ckeditor::Engine => '/ckeditor'
  root 'home#index'
  # get '/admins/sign_in' => "/admin ", as: :admin_root
  get '/' => "home#index", as: :user_root
  
  # match '/admins/sign_in' => "admins/sessions#destroy ", as: :admin_root, via: :delete
  get 'home/index'
  get 'home/about'
  # get 'home/movie_detail'
  # get 'home/movie_genres'
  # get 'home/movie_types'
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  match '/reviews/new/:id' => 'reviews#new', :as => :movie_with_review, via: :get
  match '/movie/:id' => 'home#movie_detail', :as => :movie_with_title, via: :get
  match '/movies/types/:id' => 'home#movie_types', :as => :type_with_title, via: :get
  match '/movies/genres/:id' => 'home#movie_genres', :as => :genre_with_title, via: :get  
  match 'movies/top_rated_movies/bollywood' => 'home#bollywood_top_rated', via: :get
  match 'movies/upcoming_movies/bollywood' => 'home#bollywood_upcoming', via: :get
  match '/movies/latest_movies/bollywood' => 'home#bollywood_latest', via: :get

  match 'movies/top_rated_movies/hollywood' => 'home#hollywood_top_rated', via: :get
  match 'movies/upcoming_movies/hollywood' => 'home#hollywood_upcoming', via: :get
  match '/movies/latest_movies/hollywood' => 'home#hollywood_latest', via: :get

  match 'movies/bollywood_movies' => 'home#bollywood_movies', via: :get
  match 'movies/hollywood_movies' => 'home#hollywood_movies', via: :get
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
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', passwords: 'users/passwords', confirmations: 'users/confirmations' }
  
  namespace :api do
    namespace :v1 do
      resources :movies, only: [:index,:show] do
        collection do
          post 'getTopRatedMovies'      
          post 'getLatestMovies'
          post 'getUpcomingMovies'
          post 'getMovies' 
          get 'terms'
          post 'moviedetails' 
          post 'userSaveRating'
        end
      end
      resources :users, only: [:show, :create] do
        collection do
          post 'login'
          post 'register'
          post 'forgetpass'
          post 'saveRegID'
        end
      end
      # resources :microposts, only: [:index, :create, :show, :update, :destroy]
    end
  end

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
