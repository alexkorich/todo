Rails.application.routes.draw do

 
  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
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
