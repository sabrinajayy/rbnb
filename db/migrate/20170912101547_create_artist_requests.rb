class CreateArtistRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_requests do |t|
      t.float :offer_price
      t.references :consumerevent, foreign_key: true
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
