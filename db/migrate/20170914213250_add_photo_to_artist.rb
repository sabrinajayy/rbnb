class AddPhotoToArtist < ActiveRecord::Migration[5.0]
  def change
    add_column :artists, :photo, :string
  end
end
