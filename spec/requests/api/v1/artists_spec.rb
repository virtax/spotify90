require 'rails_helper'

RSpec.describe 'Artists API', type: :request do

  describe 'GET /api/v1/:search_string' do
    it 'returns empty response for unexisted artist' do
      get_json '/api/v1/artists/unexistsed_artist_abc'
      expect(json_response).to eq []
    end

    it 'returns non empty response for known artist' do
      get_json '/api/v1/artists/madonna'
      resp = json_response
      expect(resp.count).to be > 1
      expect(resp[0]['name']).to eq 'Madonna'
    end

    it 'returns response with spotify_id, href, genres, external_urls and name for known artist' do
      get_json '/api/v1/artists/madonna'
      first_artist = json_response[0]

      expect(first_artist['spotify_id'].present?).to be true
      expect(first_artist['href'].present?).to be true
      expect(first_artist['genres'].present?).to be true
      expect(first_artist['external_urls'].present?).to be true
      expect(first_artist['name']).to eq 'Madonna'
    end
  end


  describe 'PUT /api/v1/:search_string' do
    it 'returns 404 for unexisted spotify_id' do
      put_json '/api/v1/artists/unexistsed_spotify_id'
      expect(response.status).to eq 404
    end

    it 'add the artist to Favorites table' do
      spotify_id = '6tbjWDEIzxoDsBA1FuhfPW'
      put_json "/api/v1/artists/#{spotify_id}"
      expect(Favorite.count).to be 1
      favorite = Favorite.last
      resp = json_response
      expect(favorite.spotify_id).to eq spotify_id
      expect(favorite.href).to eq resp['href']
      expect(favorite.genres).to eq resp['genres'].to_s
      expect(favorite.external_urls).to eq resp['external_urls'].to_s
      expect(favorite.name).to eq resp['name']
      expect(favorite.spotify_id).to eq spotify_id
    end

    it 'returns artist with spotify_id, href, genres, external_urls and name for known artist' do
      spotify_id = '6tbjWDEIzxoDsBA1FuhfPW'
      put_json "/api/v1/artists/#{spotify_id}"
      resp = json_response
      expect(resp['spotify_id']).to eq spotify_id
      expect(resp['href'].present?).to be true
      expect(resp['genres'].present?).to be true
      expect(resp['external_urls'].present?).to be true
      expect(resp['name']).to eq 'Madonna'
    end

  end
end
