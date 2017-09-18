class CreateTimeBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :time_blocks do |t|
      t.references :artist, foreign_key: true
      t.references :consumer_request, foreign_key: true
      t.datetime :date

      t.timestamps
    end
  end
end
