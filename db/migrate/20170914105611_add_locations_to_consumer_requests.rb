class AddLocationsToConsumerRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :consumer_requests, :latitude, :float
    add_column :consumer_requests, :longitude, :float
  end
end
