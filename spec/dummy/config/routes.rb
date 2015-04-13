Rails.application.routes.draw do

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
  mount Manufacturerx::Engine => '/manufacturer'
  mount EventTaskx::Engine => '/event_task'
  
 
  root :to => "authentify/sessions#new"
  get '/signin',  :to => 'authentify/sessions#new'
  get '/signout', :to => 'authentify/sessions#destroy'
  get '/user_menus', :to => 'user_menus#index'
  get '/view_handler', :to => 'authentify/application#view_handler'
end
