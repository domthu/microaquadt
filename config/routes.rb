ActionController::Routing::Routes.draw do |map|
  

  map.resources :batch_images

 
  map.resources :batch_samplings

  map.resources :batch_oligos


  map.resources :microarraygprs

  map.resources :gpr_headers

  map.resources :gpr_datas

  map.resources :nucleic_acids

  map.resources :nucleic_acid_types

  map.resources :filter_sample_preparations

  map.resources :sampling_equipments

  map.resources :geos

  map.resources :size_typologies

  map.resources :depths

  map.resources :geologies

  map.resources :catchment_areas

  map.resources :altitude_types

  map.resources :micro_arrays

  map.resources :microarraygals

  map.resources :gal_headers

  map.resources :gal_blocks

  map.resources :oligos

  map.resources :experiments

  map.resources :micro_array_images

  map.resources :micro_array_analysis_files

  map.resources :micro_array_validations

  map.resources :micro_array_datas

  map.resources :names
  
  map.resources :oligo_sequences
  
  map.lookforbio '/lookforbio', :controller => 'oligo_sequences', :action => 'lookup'
  map.lookforbio '/searchforbio', :controller => 'oligo_sequences', :action => 'esearch'

  map.resources :nodes

  map.resources :countries

  map.resources :wfilters

  map.resources :samplings

  map.resources :meteorological_datas

  map.resources :microposts

  map.resources :users
  map.signup '/signup',   :controller => 'users', :action => 'new'
  map.resources :sessions, :only => [:new, :create, :destroy]
  map.signin  '/signin',  :controller => 'sessions', :action => 'new'
  map.signout '/signout', :controller => 'sessions', :action => 'destroy'

  map.resources :operations
  map.resources :protocols

  map.resources :land_use_mappings

  map.resources :partner_people

  map.resources :partners

  map.resources :people

  map.resources :geos

  map.resources :code_types

  map.resources :water_types

  map.resources :water_uses

  map.resources :posts, :has_many => :comments

  map.resources :sampling_sites, :has_one => :water_uses

  map.resources :filter_samples


  # Routes for static pages.
  map.contact '/contact', :controller => 'pages', :action => 'contact'
  map.about   '/about',   :controller => 'pages', :action => 'about'
  map.help    '/help',    :controller => 'pages', :action => 'help'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.root :controller => "home"
  #test DOMTHU: other possibility
  #map.root :controller => 'pages', :action => 'home'

 # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action.:format'
  map.connect '/export_all', :controller => 'oligo_sequences', :action => 'export_all'
  map.connect '/download_sample_csv', :controller => 'batch_oligos', :action => 'download_sample_csv'
  map.connect '/download_sample_sampling_csv', :controller => 'batch_samplings', :action => 'download_sample_sampling_csv'
  map.connect '/export_to_csv', :controller => 'oligo_sequences', :action => 'export_to_csv'
  map.connect '/export_all_xls.xls', :controller => 'oligo_sequences', :action => 'export_all_xls'
  
end

