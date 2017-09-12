class CreateArtistImages < ActiveRecord::Migration[5.0]
  def change
    create_table :artist_images do |t|
      t.string :tag
      t.string :image
      t.integer :votes
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
