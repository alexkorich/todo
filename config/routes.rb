Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
 
  root to: 'application#angular'

  Todo::Application.routes.draw do
    namespace :api, defaults: {format: :json} do
      namespace :v1 do
        resources :projects do
          resources :tasks, shallow: true do
            resources :comments, shallow: true
            end
        end
      end
    end   
  end

end
