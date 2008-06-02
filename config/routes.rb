ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => 'homes' do |m|
    m.rating 'homes/rating', :action => 'rating'
    m.search 'homes/search', :action => 'search'
    m.tag 'homes/tag', :action => 'tag'
  end
  
  map.resources :homes, :tags
  map.resources :admin
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  # map.connect '', :controller => "welcome"
  map.connect '/', :controller => "homes"
  map.connect 'homes/page/:page', :controller => 'homes', :action => 'index', :page => /\d+/
  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
