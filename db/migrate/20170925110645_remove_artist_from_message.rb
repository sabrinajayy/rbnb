class RemoveArtistFromMessage < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :artist_id, :integer
  end
end
