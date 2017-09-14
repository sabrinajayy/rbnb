class AddConsumerRequestRefToArtistServices < ActiveRecord::Migration[5.0]
  def change
    add_reference :artist_services, :consumer_request, foreign_key: true
  end
end
