HeavyMachineryProjectx::Engine.routes.draw do
  resources :projects do
    collection do
      get :search
      put :search_results
      get :stats
      put :stats_results 
      #get :autocomplete
    end
  end

  root :to => 'projects#index'
end
