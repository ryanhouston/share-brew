ShareBrew::Application.routes.draw do
  root :to => "index#index"

  devise_for :users

  resources :fermentables
  resources :hops
  resources :beer_styles
  resources :yeasts
  resources :recipes do
    resources :hop_additions
    resources :yeast_additions
    resources :fermentable_additions
  end

end

