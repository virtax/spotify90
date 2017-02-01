class CreateFavorite < ActiveRecord::Migration[5.0]
  def change
    create_table :favorites do |t|
      t.string :spotify_id
      t.string :href
      t.string :name
      t.string :genres
      t.string :external_urls
    end
  end
end
