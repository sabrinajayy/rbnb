class AddDefaultToArtistRequests < ActiveRecord::Migration[5.0]
  def change
    change_column_default :artist_requests, :status, 'pending'
  end
end
