Spree::Core::Engine.routes.append do
  match "google_merchant", :to => 'products#google_merchant'

  namespace :admin do
    resource :google_merchants
  end
end