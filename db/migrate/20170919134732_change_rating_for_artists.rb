class ChangeRatingForArtists < ActiveRecord::Migration[5.0]
  def change
    change_column :artists, :rating, :float
  end
end
