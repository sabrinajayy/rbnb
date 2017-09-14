class AddServicenameToConsumerRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :consumer_requests, :servicename, :string
  end
end
