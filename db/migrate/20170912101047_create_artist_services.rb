class CreateArtistServices < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_services do |t|
      t.string :name
      t.float :price
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
