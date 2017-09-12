class CreateConsumerEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :consumer_events do |t|
      t.string :location
      t.datetime :date
      t.string :service
      t.text :description
      t.string :tags
      t.float :budget
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
