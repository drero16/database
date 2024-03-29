Rails.application.routes.draw do

  resources :adoptions do
    
    resources :comments
    resources :images
    collection do
    get 'get_drop_down_options'
  end
  end

  resources :risks do
    
    resources :comments
    resources :images
    collection do
    get 'get_drop_down_options'
  end
  end

  devise_for :users
 
  post 'images' => 'images#create'
  root to: "welcome#index"

  #resources :images
#post '/push'=> "push_notifications#create"  
post '/unsubscribe'=>"devices#unsubscribe"

  resources :events do
    resources :images
  end

  resources :information do
    resources :images
  end

  resources :notifications

 resources :comments, only: [:show]

  resources :pets do
    
    resources :comments
    resources :images
    collection do
    get 'get_drop_down_options'
  end
  end

  resources :animals do
    
    resources :comments
    resources :images
    collection do
    get 'get_drop_down_options'
  end
  end

  #resources :races

  #resources :roles

  scope "/admin" do
  resources :users, except: [:edit] do
    collection do
      get 'stats'
      get 'detailedstats'
    end
    member do
      get 'all_animals'
      get 'all_adoptions'
      get 'all_pets'
      get 'all_risks'
    end
  end
  end

  resources :devices, :only => [:create]

   get 'myposts/all_animals'
   get 'myposts/all_adoptions'
   get 'myposts/all_pets'
   get 'myposts/all_risks'
  #get 'nav/index'
#
  #get 'welcome/nav'
#
  get 'welcome/index'
#
  #get 'welcome/login'
  #get 'welcome/perdido'
  #get 'welcome/buscarperdido'
  #get 'welcome/ejemploperdido'
  #get 'welcome/info'
  #get 'welcome/ejemploencontrado'
  #get 'welcome/encontrado'
  #get 'welcome/eventos'
  #get 'welcome/buscarencontrado'
  #get 'welcome/buscaradoptado'
  #get 'welcome/adoptado'
  #get 'welcome/ejemploadoptado'
  #get 'welcome/buscarenriesgo'
  #get 'welcome/animalenriesgo'
  #get 'welcome/ejemploenriesgo'
  #
  get 'welcome/ram'
  #get 'welcome/notificaciones'
  #get 'welcome/temascreados'
#

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
