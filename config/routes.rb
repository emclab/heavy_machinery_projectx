HeavyMachineryProjectx::Engine.routes.draw do
  resources :projects

  root :to => 'hms#index'
end
