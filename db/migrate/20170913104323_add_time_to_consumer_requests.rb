class AddTimeToConsumerRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :consumer_requests, :time, :datetime
  end
end
