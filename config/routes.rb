Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    resources :filter
  end
  put '/admin/filter/' =>    "admin/filter#update"
  # resources :products do
  # 	collection do
  # 		get :facetfilter
  # 	end
  # end
  get '/search/facetfilter' => 'products#facetfilter'
end
