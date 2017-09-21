class AddEndDateToTimeBlock < ActiveRecord::Migration[5.0]
  def change
    add_column :time_blocks, :end_date, :datetime
  end
end
