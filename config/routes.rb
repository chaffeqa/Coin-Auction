CoinAuction::Application.routes.draw do |map|
  # Home Controller
  match "home" => 'home#index', :as => :home
  match "home/all_announcements" => 'home#all_announcements', :as => :all_announcements
  match "home/:id" => "home#announcement", :as => :announcement
  
  # Account Controller
  get "account/show"
  get "account/bids"
  get "account/history"
  match "logout" => 'user_sessions#destroy'
  resource :user_session, :only => [:destroy, :create, :new]

  # Auctions Module
  scope :module => "auction" do
    # CustomerAuctions Controller
    match "auctions/categories" => 'customer_auctions#categories', :as => :auctions_categories
    match "auctions/list" => 'customer_auctions#list', :as => :auctions_list
    match "auctions/view/:id" => 'customer_auctions#view', :as => :auctions_view
    # CustomerBid Controller
    resource :customer_bid, :only => [:new, :create, :destroy]
  end

  
  # Admin Namespace
  namespace "admin" do
    get "home/index"
    resources :auctions do
      delete :destroy_bid, :on => :member
    end
    resources :items
    resources :announcements
    resources :users
  end

  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
