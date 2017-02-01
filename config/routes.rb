Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: redirect("api/v1/artists/madonna")

  namespace :api, constraints: { format: :json } do
    namespace :v1 do
      get   'artists/:search_string' => 'artists#index'
      put   'artists/:spotify_id'    => 'artists#mark_as_favorite'
    end
  end

end
