Tweegeo::Application.routes.draw do

  resources :tweets do
    collection do
      match 'geo' => 'tweets#geo', as: :geo
    end
  end

  root to: 'tweets#index'

end