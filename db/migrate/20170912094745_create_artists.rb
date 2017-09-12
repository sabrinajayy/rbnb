class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :first_name
      t.string :last_name
      t.string :location
      t.integer :travel_range
      t.string :tags
      t.text :bio
      t.string :instagram_handle
      t.time :avg_response_time
      t.float :confirmation_rate
      t.integer :rating
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
