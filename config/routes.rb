Rails.application.routes.draw do
  # Workbench Resources
  root 'workbench#index'
  get   'workbench' => 'workbench#workbench'
  get   'vcl'       => 'workbench#vcl'
  get   'about'     => 'workbench#about'

  # Pages Resource
  get   'page'      => 'pages#show'
  post  'page'      => 'pages#update'
  get   'page/edit' => 'pages#edit'

  # CacheControls Resource
  get   'cachecontrol' => 'cachecontrols#edit'
  post  'cachecontrol' => 'cachecontrols#update'

  # Housekeeping Resource
  get 'housekeeping/refresh' => 'housekeeping#refresh'
  get 'housekeeping/purge'   => 'housekeeping#purge'
  get 'housekeeping/ban'     => 'housekeeping#ban'
end
