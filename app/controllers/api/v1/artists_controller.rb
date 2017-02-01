require 'rest-client'
require 'multi_json'

class Api::V1::ArtistsController < Api::V1::ApplicationController

  helper_method :resource, :scope

  def index
    render :index
  end

  def mark_as_favorite
    Favorite.find_or_create_by(spotify_id: spotify_id) do |favorite|
      favorite.spotify_id = spotify_id
      favorite.name = resource['name']
      favorite.href = resource['href']
      favorite.genres = resource['genres']
      favorite.external_urls = resource['external_urls']
    end
    render 'favorite'
  rescue RestClient::NotFound, RestClient::BadRequest
    not_found
  end

  private

  def spotify_id
    params.require(:spotify_id)
  end

  def scope
    @scope ||= begin
      search_string = params.require(:search_string)
      response = RestClient.get "https://api.spotify.com/v1/search?type=artist&limit=50&q=#{search_string}"
      MultiJson.load(response.body)['artists']['items'].to_a
    end
  end

  def resource
    @resource ||= begin
      response = RestClient.get "https://api.spotify.com/v1/artists/#{spotify_id}"
      MultiJson.load(response.body)
    end
  end
end


