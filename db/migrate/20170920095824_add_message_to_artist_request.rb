class AddMessageToArtistRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :artist_requests, :message, :string
  end
end
