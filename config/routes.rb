HeavyMachineryProjectx::Engine.routes.draw do
  resources :projects do
    collection do
      get :search
      get :search_results
      get :stats
      get :stats_results 
      #get :autocomplete
    end
  end

  root :to => 'projects#index'
end
