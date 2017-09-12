class CreateConsumerRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :consumer_requests do |t|
      t.float :base_price
      t.float :fees
      t.float :final_price
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
