Rails.application.routes.draw do

  get "user_menus/index"

  mount HeavyMachineryProjectx::Engine => "/heavy_machinery_projectx"
  mount Commonx::Engine => "/commonx"
  mount Authentify::Engine => '/authentify'
  mount Kustomerx::Engine => '/customerx'
  mount Searchx::Engine => '/searchx'
  mount SourcedPartx::Engine => '/src_part'
  mount SuppliedPartx::Engine => '/pur_part'
  mount StateMachineLogx::Engine => '/sm_log'
  mount BizWorkflowx::Engine => '/biz_wf'
  mount Supplierx::Engine => '/supplier'
  mount EventTaskx::Engine => '/event_task'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
