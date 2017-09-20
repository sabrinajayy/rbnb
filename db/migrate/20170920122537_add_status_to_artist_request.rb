class AddStatusToArtistRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :artist_requests, :status, :string, default: 'pending'
  end
end
