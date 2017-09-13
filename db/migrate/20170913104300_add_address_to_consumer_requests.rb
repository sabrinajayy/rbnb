class AddAddressToConsumerRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :consumer_requests, :address, :text
  end
end
